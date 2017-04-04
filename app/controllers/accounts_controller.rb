class AccountsController < ApplicationController
  # load_and_authorize_resource except: :change_password
  before_filter :authenticate_account!, except: :check_facebook_login
  before_action :require_office_account, only: [:listings]
  def show
    if current_account.present?
      #@listings = Listing.joins(:reputations).
        #where("reputations.account_id = ?", current_account.id).
        #page(params[:page]||1).per(8)
      redirect_to edit_account_path
    else
      redirect_to new_account_session_path
    end
  end

  def listings
    #if params[:status] == Settings.listing_status.actived
      #@listings = current_account.listings.where(status: [0, -1])
    #else
      #@listings = current_account.listings.expired
    #end
  end

  def verify_office
    @account = Account.find_by_email(params[:email])
    @account.add_office_token
    if @account.office_token.present?
      MailNotifyWorker.perform_async(@account.id, :verify_office_account, {})
      redirect_to new_listing_path, notice: "The email has been sent successfully."
    else
      redirect_to new_listing_path, notice: "The email failed to send."
    end
  end

  def saved_wishlist
    @listings = Listing.enables.joins(:reputations).
      where("reputations.account_id = ?", current_account.id).
      where(flag: get_rental_or_sale_id).order('listings.id desc').
      page(params[:page]||1).per(8)
  end

  def past_wishlist
    @listings = Listing.expired.joins(:reputations).
      where("reputations.account_id = ?", current_account.id).
      where(flag: get_rental_or_sale_id).order('listings.id desc').
      page(params[:page]||1).per(8)
  end

  def room_wishlist
    @rooms = Room.active.joins(:reputations).
      where("reputations.account_id=?", current_account.id).
      where("reputations.category=?","Room").
      page(params[:page]||1).per(8)
  end

  def room_cart
    @rooms = Room.active.joins(:reputations).
      where("reputations.account_id=?",current_account.id).
      where("reputations.category=?","ltcart").
      page(params[:page]||1).per(8)
  end

  def roommate_cart
    @roommates = Roommate.active.joins(:reputations).
      where("reputations.account_id=?",current_account.id).
      where("reputations.category=?","qhcart").
      page(params[:page]||1).per(8)
  end

  def room_cart_agreement
  end

  def room_cart_checkout
  end

  def purchase_lt
    if current_account.lt_purchase_state == 0
      current_account.lt_purchase_state = 1
      current_account.save
      redirect_to account_room_cart_agreement_path
    elsif current_account.lt_purchase_state == 1
      current_account.lt_purchase_state = 2
      current_account.save
      redirect_to account_room_cart_checkout_path
    elsif current_account.lt_purchase_state == 2
      current_account.lt_purchase_state = 3
      current_account.save
      redirect_to account_room_cart_path, notice: "Successfully purchased"
    elsif current_account.lt_purchase_state == 3
      current_account.lt_purchase_state = 4
      current_account.save
      redirect_to account_room_cart_path, notice: "wait for refund please"
    else
      current_account.lt_purchase_state = 0
      current_account.save
      redirect_to account_room_cart_path
    end
  end

  def roommate_cart_agreement
  end

  def roommate_cart_checkout
  end

  def purchase_qh
    if current_account.qh_purchase_state == 0
      current_account.qh_purchase_state = 1
      current_account.save
      redirect_to account_roommate_cart_agreement_path
    elsif current_account.qh_purchase_state == 1
      current_account.qh_purchase_state = 2
      current_account.save
      redirect_to account_roommate_cart_checkout_path
    elsif current_account.qh_purchase_state == 2
      current_account.qh_purchase_state = 3
      current_account.save
      redirect_to account_roommate_cart_path, notice: "Successfully purchased"
    elsif current_account.qh_purchase_state == 3
      current_account.qh_purchase_state = 4
      current_account.save
      redirect_to account_roommate_cart_path, notice: "wait for refund please"
    else
      current_account.qh_purchase_state = 0
      current_account.save
      redirect_to account_roommate_cart_path
    end
  end

  def my_room_postings
    collection = Room.where(account_id: current_account.id)
    Roommate.where(account_id: current_account.id).each{|r| collection << r}
    all_posts = collection.sort_by(&:created_at).reverse
    @posts = Kaminari.paginate_array(all_posts).page(params[:page]).per(8)
  end

  def check_facebook_login
    if current_account && current_account.logined_facebook?
      render json: {logined: true}
    else
      render json: {logined: false}
    end
  end

  def account_params
    params.require(:account).permit(devise_parameter_sanitizer.for(:sign_up))
  end

  def require_office_account
    unless current_account.present? && (current_account.is_office_account? or current_account.admin?)
      redirect_to :back, alert: "You don't have permission to access this page."
    end
  end
end
