class Building < ActiveRecord::Base
  VALID_COLS = { year_built: ->(y) { y && y != '0'}}

  enum flag: [:csv_sources, :custom]

  has_many :building_listings
  has_many :listings, through: :building_listings

  scope :review_buildings, ->{ where(id: Venue.buildings.pluck(:region_id)) }

  after_create :improve_building, if: ->(building) { building.city == 'NYC' && building.custom? }
  before_save :set_amenities

  alias_attribute :floors, :num_floors
  alias_attribute :units, :units_total

  serialize :amenities, Array

  include GeoHelper

  def self.init_ny_building_from_csv
    require 'csv'
    boros = ['MN', 'BK', 'QN', 'SI', 'BX']
    boros.each do |csv|
      csv = Rails.root.join('db/buildings/nyc', "#{csv}.csv")
      row_i = 0
      keys = []
      CSV.foreach csv do |row|
        if row_i == 0
          keys = row.map(&:underscore)#.select{|s| column_names.include? s.to_s}
        else
          hash = {city: 'NYC', flag: 0}
          keys.each_with_index{|key, i|
            hash[key.to_sym] = row[i] if column_names.include? key
          }
          unless VALID_COLS.keys.any?{|s| !VALID_COLS[s].call(hash[s])}
            unless Building.unscoped.exists?(hash.slice(:city, :borough, :address, :flag))
              Building.unscoped.where(hash.slice(:city, :borough, :address, :flag)).first_or_initialize.update_attributes hash
            end
          end
        end
        row_i += 1
        if row_i % 500 == 0
          p row_i
          p hash
        end
      end
    end
  end

  def self.init_ny_building_from_sql
    require 'zip'
    Dir[Rails.root.join('db/buildings/nyc/*.zip')].each do |zip|
      Zip::File.open(zip) do |z_file|
        z_file.each do |f|
          sql = File.join(File.dirname(zip), f.name)#File.join()
          z_file.extract f, sql  unless File.exist? sql
          config = ActiveRecord::Base.connection_config
          exec_sql = "mysql"
          exec_sql += " -u#{config[:username] || 'root'}" # if config[:username]
          exec_sql += " -p#{config[:password]}" if config[:password]
          exec_sql += " -h #{config[:host]}" if config[:host]
          exec_sql += " #{config[:database]} < #{sql}"
          `#{exec_sql}`
        end
      end
    end
  end

  def self.nyc_boroughs
    ['mn', 'bx', 'bk', 'qn', 'si']
  end
  def self.nyc_borough_hashes
    {
      mn: 'Manhattan',
      bx: 'Bronx',
      bk: 'Brooklyn',
      qn: 'Queens',
      si: 'Staten Island'
    }
  end

  def borough_sub_ids
    if self.city == 'NYC' && self.borough
      areas = PoliticalArea.nyc.sub_areas.where(long_name: Building.nyc_borough_hashes[self.borough.downcase.to_sym])
      areas.map{|s| s.sub_ids(include_self: true)}.flatten.uniq
    end
  end

  def address_translator_url
    AddressTranslator.address_translator_url self.address, borough: self.borough, city: self.city
  end

  def same_addresses
    @same_addresses ||= AddressTranslator.address_translator_same_addresses self.address, borough: self.borough, city: self.city
    @same_addresses
  end

  def same_street_addresses
    AddressTranslator.same_street_addresses same_addresses
  end

  def improve_building
    building = AddressTranslator.get_master_building_by_building self#get_building_from_address same_addresses
    if building
      attrs = building.attributes.reject{|s|['id', 'address'].include? s}
      self.update_columns attrs
    end
  end

  def self.improve_address opt={size: 20000, time_limit: 80000}
    begin_id = 0
    ids = []
    id_size = 0
    opt[:time_limit] ||= 80000
    opt[:size] ||= 20000
    size = opt[:size]
    times = 800000 / opt[:time_limit]
    key = 'building:improve_address:index'
    current_index = $redis.get(key).to_i
    (1..times).each do |page|
      begin_id += opt[:time_limit]
      Building.csv_sources.where(city: 'NYC').where("borough != 'MN'").where('id > ?', current_index)
        .order(:id).page(page)
        .per(opt[:time_limit]).pluck(:id, :address).each do |arr|
        break if id_size > size
        if arr[1] && arr[1].split(/\s/)[1..-1].select{|s| s.size < 4}.size > 0
          ids << arr[0]
          id_size += 1
        end
      end
      break if id_size > size
    end
    $redis.set key, ids.last
    buildings = Building.where(id: ids).select(:borough, :id, :address, :city)
    buildings.each do |building|
      building.improve_address
    end
  end

  def geo
    if self.city == 'NYC'
      addr = "#{self.address}, #{self.borough}, NY, USA"
    else
      addr = "#{self.address}"
      addr << ", #{self.borough}" if self.borough
      addr << ", #{self.borough}" if self.try(:city)
      addr << ", USA"
    end
    do_geocode(addr)
  end

  def improve_address
    geo = self.geo
    if geo.success? && geo.place_types.include?('street_address') && geo.street_address
      others = Building.custom.where(city: self.city, borough: self.borough, address: geo.street_address)
      Venue.where(region: others).update_all region_id: self.id
      others.destroy_all
      self.update_columns address: geo.street_address
    end
  end

  def set_amenities
    if self.amenities.present? && String === self.amenities
      self.amenities = self.amenities.split(',').map(&:strip)
    else
      self.amenities = []
    end
  end
  private :set_amenities

  def set_relate_listings
    if self.borough && self.city == 'NYC'
      same_street_addresses.each do |st|
        lls = Listing.where(political_area_id: borough_sub_ids, is_full_address: true)
        while m = st.match(/\s(\d+)\s/)
          st.sub!(m[0], " #{m[1]}% ")
        end
        lls = lls.where('formatted_address like ?', "#{st}%")
        lls.each do |l|
          building_listings.where(listing: l).first_or_create
        end
      end
    end
  end

  class << self
    def boroughs
      @@borough ||= Building.where("borough is not null").distinct(:borough).select(:borough).pluck(:borough).flatten
    end
    def cities
      @@cities ||= Building.where("borough is not null").distinct(:city).select(:city).pluck(:city).flatten
    end
  end
end
