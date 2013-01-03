class Subscription < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user
  has_many :sources

  after_create :subscribe
  after_destroy :unsubscribe

  scope :recent, :limit => 30

  def unlistened_source_count
    sources.count
  end
  protected

    def subscribe
     SubscriptionService.subscribe(url, id) 
    end

    def unsubscribe
     SubscriptionService.unsubscribe(url, id) 
    end

end
