class AddIndexToSubscriptions < ActiveRecord::Migration
  def up
    add_index :subscriptions, :series_id
  end

  def down
    remove_index :subscriptions, :series_id
  end
end
