class Roommate < ActiveRecord::Base
  enum status: %w(active expired)
  belongs_to :account
  has_many :photos, as: :imageable, dependent: :destroy
  has_many :reputations, as: :reputable, dependent: :destroy

  serialize :pets_allowed, Array
  serialize :borough, Array

  validates :about_me, length: {minimum: 10}
  validates_presence_of  :title, :move_in_date, :duration,
    :title
    #:budget, :gender, :pets_allowed, :borough

  alias_method :images, :photos

  def self.sort_by_created
    active.sort{ |a,b| b.created_at <=> a.created_at }
  end

  def to_param
    "#{id}-#{clean_url}"
  end

  def clean_url
    title.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
