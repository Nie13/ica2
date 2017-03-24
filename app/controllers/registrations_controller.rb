class RegistrationsController < Devise::RegistrationsController
  def update
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    # For Rails 3
    # account_update_params = params[:user]

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = current_account
    @user.sickness = current_account.sickness
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to :back
    else
      flash.now[:notice] = resource.errors.full_messages.first
      render "edit"
    end
  end

  def create
    if request.xhr?
      build_resource(account_params)
      if resource.save
        binding_review resource
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_in(resource_name, resource)
          return render :json => {:success => true, redirect_to: session[:redirect_to]}
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          return render :json => {:success => true, redirect_to: session[:redirect_to]}
        end
      else
        clean_up_passwords resource
        return render :json => {:success => false}
      end
    else
      super
    end
  end

  def account_params
    #if action_name == 'sign_up'
      #params.require(:account).permit(:first_name, :last_name, :birth_date, :role)
    #if action_name == 'update'
      #params.require(:account).permit(:first_name, :last_name, :birth_date, :image, :first_phone, :last_phone, need_help: [], sickness: [])
    #end
    #else
    params.require(:account).permit(devise_parameter_sanitizer.for(:sign_up))
    #end
  end
end
