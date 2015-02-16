class RemoveUseridAndSubscriptionIdFromSources < ActiveRecord::Migration
  def up
    remove_column :sources, :user_id
    remove_column :sources, :subscription_id
  end

  def down
    add_column :sources, :subscription_id, :integer
    add_column :sources, :user_id, :integer
  end
end
