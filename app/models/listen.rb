class Listen < ActiveRecord::Base
  attr_accessible :client, :finish_time, :source_id, :start_time, :user_id
  validates_presence_of :source_id, :user_id
  belongs_to :user
  belongs_to :source
end
