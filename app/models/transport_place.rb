class TransportPlace < ActiveRecord::Base
  belongs_to :political_area
  has_many :transport_distances
  class << self
    def init_data
      nyc = PoliticalArea.default_area
      Settings.transport_places.each do |tp|
        borough = nyc.sub_areas.where(tp.borough).first || PoliticalArea.where(tp.borough).first
        if borough
          tp.places.each do |place|
            t_place   = borough.transport_places.where(place).first_or_initialize
            next unless t_place.new_record?
            geo = $geocoder.geocode place.formatted_address
            if geo.success
              t_place.lat = geo.lat
              t_place.lng = geo.lng
              t_place.save
            end
          end
        end
      end
    end

    def retrieve_transport_political_area(area)
      return nil unless area
      select('distinct political_area_id').each do |t_area|
        return t_area.political_area if t_area.political_area.sub_areas(include_self: true).include?(area)
      end
      TransportPlace.first.political_area
    end
  end
end
