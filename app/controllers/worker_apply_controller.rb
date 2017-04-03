class WorkerApplyController < ApplicationController
  def new
    @application = WorkerApply.new
    @application.worker_files.build
  end

  def create
    @application = WorkerApply.new(apply_params)
    if params[:worker_apply][:documents_attributes]
      create_docs(@application)
    end
    if @application.save
      redirect_to apply_confirm_path(@application)
      #RoomContactMailer.token_confirm(@application).deliver
      #mail = RoomContactMailer.worker_application(@application)
      #mail.deliver
    else
      flash.now[:alert] = "Something went wrong."
      render :new
    end
  end

  def show
    @application = WorkerApply.find params[:id]
  end

  def retrieve
  end

  def edit
    @update_flag = true
    token = params[:token]
    dob = Date.strptime(params[:dob], "%m/%d/%Y") rescue nil
    email = params[:email]
    @application = WorkerApply.find_by(access_token: token, dob: dob, email: email)
    respond_to do |format|
      if @application
        @documents = @application.documents
        format.js {}
        #format.json { render json: @documents }
      else
        @error = true
        format.js {
          flash.now[:alert] = "Please enter valid credentials"
        }
      end
    end
  end

  def update
    id = params[:worker_apply][:id]
    if params[:worker_apply][:documents_attributes]
      @application = WorkerApply.find(id)
      create_docs(@application)
    end
    flash[:notice] = "Updated successfully."
    redirect_to apply_retrieve_path
  end

  def destroy
    @document = WorkerFiles.find params[:id]
    client_id = @document.client_id
    @document.destroy
    @application = WorkerApply.find(worker_id)
    @documents = @application.worker_files
    @update_flag = true
    respond_to do |format|
      format.html { redirect_to apply_retrieve_path }
      format.js { flash.now[:notice] = "Deleted file succesfully."}
    end
  end

  private

  def apply_params
    params.require(:worker_apply).permit(:first_name, :last_name, :dob, :phone, :email, :edu_level, :nav_place, :home_address, :start_date, :salary_quest, :ltservice, :qhservice, :available_from, :available_to, :begin_time, :end_time, :pet, :breed, :pet_name, :pet_age, :pet_weight, :emergency_name, :emergency_addr, sicknesses:[], helps: [])
  end

  def doc_params
    params.require(:worker_apply).require(:documents_attributes).permit(nurse: [], primary_caregiver: [], middle_caregiver: [], high_caregiver: [], standard_caregiver: [], first_add_certificate: [])
  end

  def create_docs(application)
    doc_params.each do |key, val|
      val.each do |doc|
        application.worker_files << WorkerFiles.new(name: doc, doc_type: key)
      end
    end
  end

end
