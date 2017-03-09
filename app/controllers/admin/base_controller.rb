class Admin::BaseController < ApplicationController
  #before_filter :authenticate_user!
  layout 'admin'
  before_filter :require_admin
  helper_method :sort_column, :sort_direction

  def require_admin
    unless (current_account.present? and current_account.can_manage_site?)
      raise CanCan::AccessDenied
    end
  end

  def sort_column
    params[:controller] == "admin/page_views" ? params[:sort] || "updated_at" : params[:sort] || "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
