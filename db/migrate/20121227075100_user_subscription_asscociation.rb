class UserSubscriptionAsscociation < ActiveRecord::Migration
  def up
    add_column :subscriptions, :user_id, :integer
    add_index :subscriptions, :user_id
  end

  def down
    remove_column :subscriptions, :user_id
  end
end
