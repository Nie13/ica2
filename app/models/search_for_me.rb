class SearchForMe < ActiveRecord::Base
  serialize :boroughs, Array
  serialize :transportation, Array
  validates :name, :beds, :baths, :budget, :move_in_date, :email, presence: true
  validates :is_employed, inclusion: { in: [true, false]}
end
