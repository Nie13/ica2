class Admin::SearchForMesController < Admin::BaseController
  def index
    @form = SearchForMe.all.page params[:page]
  end
end
