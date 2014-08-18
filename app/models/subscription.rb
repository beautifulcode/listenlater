class Subscription < ActiveRecord::Base

  belongs_to :series
  belongs_to :user
  has_many :sources

  def unlistened_source_count
    sources.count
  end

end
