class WorkerFiles < ActiveRecord::Base
  belongs_to :worker_apply
  mount_uploader :name, DocumentUploader
  attr_accessor :nurse, :primary_caregiver, :middle_caregiver, :high_caregiver, :standard_caregiver, :first_add_certificate
end
