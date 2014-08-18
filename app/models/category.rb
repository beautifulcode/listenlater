class Category < ActiveRecord::Base
  attr_accessible :subscription_count, :title
  has_many :subscriptions
  has_many :series
  scope :ordered, :order => "title ASC"

  extend FriendlyId
  friendly_id :title, use: :slugged


  def icon
    "icons/#{title.downcase.gsub(' ', '-')}.png"
  end

end
