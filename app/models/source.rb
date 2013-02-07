class Source < ActiveRecord::Base

  attr_accessible :title, :url

  belongs_to :user
  belongs_to :subscription
  has_many :listens

  scope :popular, :limit => 30
  scope :suggested, :limit => 30
  scope :recent, :limit => 30
  scope :ordered, :order => "created_at DESC"
  scope :unlistened, :conditions => {:listened => false}
  scope :listened, :conditions => {:listened => true}

  def state_classes
    class_array = []
    class_array << 'listened' if listened?
    class_array
  end

  def mark_as_listened
    self.listened ||= true
    save if listened_changed?
  end

end
