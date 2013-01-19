class Listen < ActiveRecord::Base
  attr_accessible :client, :finish_time, :source_id, :start_time, :user_id
end
