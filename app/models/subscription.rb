class Subscription < ActiveRecord::Base

  belongs_to :series
  belongs_to :user
  has_many :sources, :through => :series

  def unlistened_source_count
    sources.count
  end

end
