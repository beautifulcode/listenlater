class Source < ActiveRecord::Base

  attr_accessible :title, :url
  attr_accessor :listened

  belongs_to :user
  belongs_to :subscription

  scope :recent, :limit => 30

  def state_classes
    class_array = []
    class_array << 'listened' if listened?
    class_array
  end

  def listened?
    false
  end

end
