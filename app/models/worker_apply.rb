class WorkerApply < ActiveRecord::Base
  serialize :sicknesses, Array
  serialize :helps, Array
  has_many :worker_files, dependent: :destroy, class_name: 'WorkerFiles', foreign_key: 'worker_id'
  accepts_nested_attributes_for :worker_files, reject_if: :all_blank
  before_create :set_access_token

  def dob=(s)
    write_attribute(:dob, Date.strptime(s, "%m/%d/%Y"))
  end

  def available_from=(s)
    write_attribute(:available_from, Date.strptime(s, "%m/%d/%Y"))
  end

  def available_to=(s)
    write_attribute(:available_to, Date.strptime(s, "%m/%d/%Y"))
  end

  private

  def set_access_token
    self.access_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(3)
      break token unless WorkerApply.where(access_token: token).exists?
    end
  end

end
