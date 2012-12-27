class Subscription < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user
  has_many :sources

  scope :recent, :limit => 30
end
