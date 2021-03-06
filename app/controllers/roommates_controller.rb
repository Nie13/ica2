class RoommatesController < ApplicationController
  before_action :account_signed_in?, only: [:create, :update, :detroy, :new]

  def index
    sorted_roommates = Roommate.sort_by_created.first(3)
    roommates =  Kaminari.paginate_array(sorted_roommates)
      .page(params[:page]).per(24)

    link_hash = {
      "所有服务列表" => alllists_path,
      "长期陪护" => rooms_path
    }

    render "room_search/_index_layout",
      locals: {
      total_post_count: sorted_roommates.count,
        posts: roommates,
        heading: "一键到家列表",
        new_path: new_roommate_path,
        link_hash: link_hash
      }
  end

  def show
    @roommate = Roommate.find(params[:id])
    if @roommate.expired?
      flash[:notice] = "服务过期"
    end
  end

  def new
    @roommate = Roommate.new
  end

  def create
    @roommate = current_account.roommates.new(roommate_params)
    photo_ids = params[:photo_ids]
    if photo_ids.present?
      photo_ids.split(',').each do |id|
        @roommate.photos << Photo.find(id) if id.present?
      end
    end
    if !current_account.logined_facebook?
      if @roommate.save
        flash[:notice] = "已发布新QH服务"
        redirect_to @roommate
      else
        flash[:alert] = @roommate.errors.full_messages.join(", ")
        render :new
      end
    else
     flash[:alert] = "sign in needed!"
     render :new
    end
  end

  def edit
    @roommate = Roommate.find(params[:id])
    if current_account != @roommate.account
      redirect_to @room
      flash[:notice] = "oops something went wrong ¯\\_(ツ)_/¯"
    end
  end

  def expire
    @roommate = Roommate.find(params[:roommate_id])
    @roommate.expired!
    redirect_to roommates_path, notice: "服务已过期"
  end

  def update
    @roommate = Roommate.find(params[:id])
    if @roommate.update(roommate_params)
      flash[:notice] = "QH服务已更新"
      redirect_to @roommate
    else
      flash[:alert] = @roommate.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @roommate = Roommate.find(params[:id])
    @roommate.destroy
    respond_to do |format|
      format.html { redirect_to roommates_url, notice: 'QH服务已删除' }
      format.json { head :no_content }
    end
  end

  def send_message
    id =  params[:roommate_id].split('-').first
    @roommate = Roommate.find id
    name = params[:Name]
    email = params[:Email]
    description = params[:Description]
    phone = params[:Phone]
    subject = "#{name} is Interested QH"
    body = "Contact Info:\nName: #{name}\nEmail: #{email}\n"
    if !phone.empty?
      body << "Phone: #{phone}\n"
    end
    body << "\n\n"
    RoomContactMailer.contact_email(email, subject, body,  description, @roommate).deliver
    @roommate.update_attributes(contacted: @roommate.contacted + 1)
    flash[:notice] =  "Message sent"
    redirect_to roommate_path params[:roommate_id]
  end

  def add_to_roommate_cart
    @roommate = Roommate.find(params[:roommate_id])
    if current_account.roommate_carted? @roommate
      reputation = current_account.get_roommate_carted(@roommate)
      reputation.destroy
      respond_to do |format|
        format.html{ redirect_to @roommate, flash: {notice:"discarted"}}
      end
    elsif Reputation.where(category: "qhcart", account_id: current_account.id).count != 3
      Reputation.create({reputable: @roommate, category: 'qhcart', account_id: current_account.id})
      respond_to do |format|
        format.html { redirect_to @roommate,flash: {notice: "carted"}}
      end
    else
      respond_to do |format|
        format.html { redirect_to @roommate,flash: {notice: "cannot cart for more than 3!!!!"}}
      end
    end
  end

  protected

  def roommate_params
    params_hash = params.require(:roommate).permit(
      :gender, :budget, {pets_allowed: []}, {borough: []}, :about_me,
      :students_only, :raw_neighborhood,
      :title, :num_roommates, :location, :move_in_date,
      :duration
    )

    if params_hash[:budget].present?
      params_hash[:budget] =  params_hash[:budget].split(".")[0].gsub(/[^0-9]/,'')
    end

    params_hash[:borough] ||= []
    params_hash[:pets_allowed] ||= []

    params_hash
  end
end
