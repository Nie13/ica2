class AgentsController < ApplicationController
  def show
    @agent = Agent.find(params[:id])
    @listings = @agent.listings.enables.order(id: :desc).page(params[:page]).per(10)

    @page_title = "#{@agent.name} - Agent"
    if params[:page]
      @page_title << ", Page #{params[:page]}"
    end
    @page_title << " | CitySpade"
    @page_description = @agent.remark.try(:limit, 120)
  end

end
