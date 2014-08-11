class Subscription < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :series
  belongs_to :user
  has_many :sources

  after_create :subscribe
  after_destroy :unsubscribe

  scope :recent, :limit => 30

  acts_as_taggable

  def unlistened_source_count
    sources.count
  end

  def url
    series.url
  end

  protected

    def subscribe
     SubscriptionService.subscribe(url, id)
    end

    def unsubscribe
     SubscriptionService.unsubscribe(url, id)
    end

end
