class Category < ActiveRecord::Base
  attr_accessible :subscription_count, :title
  has_many :subscriptions
  scope :ordered, :order => "title ASC"

  def icon
    "icons/#{title.downcase.gsub(' ', '-')}.png"
  end

end
