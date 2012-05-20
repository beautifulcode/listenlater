class Source < ActiveRecord::Base
  attr_accessible :title, :url
  belongs_to :subscription
end
