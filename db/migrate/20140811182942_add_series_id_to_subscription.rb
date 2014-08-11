class AddSeriesIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :series_id, :integer
  end
end
