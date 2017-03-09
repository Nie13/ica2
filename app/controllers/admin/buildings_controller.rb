class Admin::BuildingsController < Admin::BaseController
  before_action :set_admin_building, only: [:show, :edit, :update, :destroy, :relate_listings]

  # GET /admin/buildings
  # GET /admin/buildings.json
  def index
    @buildings = Building.page(params[:page])
    if params[:sort].present?
      @buildings = @buildings.order("#{sort_column} #{sort_direction}")
    end
    @buildings = @buildings.where city: params[:city]  if params[:city]
    @buildings = @buildings.where borough: params[:borough]  if params[:borough]
    if params[:street_number].present? || params[:street_name].present?
      addr = "#{params[:street_number].strip} #{params[:street_name].strip}"
      if addr =~ /^\d/
        @buildings = @buildings.where("address like ?", "#{addr}%")
      else
        @buildings = @buildings.where("address like ?", "%#{addr}%")
      end
      if @buildings.blank? && params[:street_name].present?
        building = AddressTranslator.find_building_from_address_translator addr, params.slice(:city, :borough)
        if building
          @buildings = Building.where(id: building.id).page params[:page]
        end
      end
    end
  end

  # GET /admin/buildings/1
  # GET /admin/buildings/1.json
  def show
  end

  # GET /admin/buildings/new
  def new
    @building = Building.new city: 'NYC'
    # @admin_building = Admin::Building.new
  end

  # GET /admin/buildings/1/edit
  def edit
  end

  def relate_listings
    @building.set_relate_listings
    render action: :show
  end

  # POST /admin/buildings
  # POST /admin/buildings.json
  def create
    @admin_building = Building.new(admin_building_params)

    respond_to do |format|
      if @admin_building.save
        format.html { redirect_to admin_building_path(@admin_building), notice: 'Building was successfully created.' }
        format.json { render :show, status: :created, location: @admin_building }
      else
        format.html { render :new }
        format.json { render json: @admin_building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/buildings/1
  # PATCH/PUT /admin/buildings/1.json
  def update
    respond_to do |format|
      if @building.update(admin_building_params)
        listing_ids = []
        if params[:related_listing_ids].present?
          listing_ids = params[:related_listing_ids].split(',').map(&:to_i)
        end
        origin_ids = @building.building_listings.pluck(:listing_id)
        @building.building_listings.where(listing_id: origin_ids - listing_ids).delete_all
        (listing_ids - origin_ids).each do |l_id|
          @building.building_listings.create(listing_id: l_id)
        end
        format.html { redirect_to admin_building_path(@building), notice: 'Building was successfully updated.' }
        format.json { render :show, status: :ok, location: @building }
      else
        format.html { render :edit }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/buildings/1
  # DELETE /admin/buildings/1.json
  def destroy
    @admin_building.destroy
    respond_to do |format|
      format.html { redirect_to admin_buildings_url, notice: 'Building was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_building
    @building = Building.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_building_params
    if action_name == 'create'
      params.require(:building).permit(:city, :borough, :name, :address, :year_built, :units_total, :description, :amenities)
    else
      params.require(:building).permit(:year_built, :floors, :units_total, :name, :description, :amenities)
    end
  end
end
