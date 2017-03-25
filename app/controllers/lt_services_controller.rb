class LtServicesController < ApplicationController
  before_action :authenticate_account!, except: [:index, :show]
  before_action :account_signed_in?, only: [:create, :update, :destory]
  before_action :set_custom_formId, only: [:new, :edit, :create, :update]

  def index
    all_services = WorkerApply.unscoped.all
    lt_services = all_services.where(ltservice == true)
    #act_lt_services = lt_services.where(status )

  end
