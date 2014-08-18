class Source < ActiveRecord::Base

  attr_accessible :title, :url

  belongs_to :user
  belongs_to :subscription
  has_one :series, :through => :subscription
  has_many :listens

  acts_as_taggable

  extend FriendlyId
  friendly_id :title, use: :slugged


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

  def subscription_title
    subscription ? subscription.title : self.created_at.to_s(:long)
  end

  def image_url
    default_image_url
  end

  def default_image_url
    'series/default.gif'
  end

  def series_title
    series.try(:title)
  end

end
