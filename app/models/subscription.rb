class Subscription < ActiveRecord::Base
  attr_accessible :title, :url
  has_many :sources
end
