class ClientApplyController < ApplicationController
  before_filter :set_locale

  def new
  end

  def create
    info = params
    #mail = RoomContactMailer.client_application(info)
    #if mail.deliver
      #redirect_to apply_confirm_path
    #else
      #render :new
    end
  end

  def confirmation
  end

  private

  def set_locale
    if params[:locale].present?
      I18n.locale = params[:locale]
    else
      I18n.locale = 'ch'
    end
  end


end
