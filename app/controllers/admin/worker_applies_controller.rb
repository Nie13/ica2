class Admin::WorkerAppliesController < Admin::BaseController
  def index
    fname = params[:first_name]
    lname = params[:last_name]
    #email = params[:email]
    phone = params[:phone]
    @form = WorkerApply.all
    if fname || lname || phone
      @form = @form.where("first_name like ?", "%#{fname}") unless fname.blank?
      @form = @form.where("last_name like ?", "%#{lname}") unless lname.blank?
      @form = @form.where("phone like ?", "%#{phone}") unless phone.blank?
    end

    @form = @form.order(id: :desc).page(params[:page]).per(25)

  end

  def activate_as_lt
    @form = WorkerApply.find(params[:id])
    @form.ltservice = true
    @form.status = 3
    @form.save
    redirect_to admin_worker_apply_path, notice: "successfully activated as lt"
  end

  def activate_as_qh
    @form = WorkerApply.find(params[:id])
    @form.qhservice = true
    @form.status = 3
    @form.save
    redirect_to admin_worker_apply_path, notice: "successfully activated as qh"
  end

  def diable
    @form = WorkerApply.find(params[:id])
    @form.ltservice = false
    @form.status = 4
    @form.save
    redirect_to admin_worker_apply_path, notice: "disabled all service"
  end

end
