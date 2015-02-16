class RemoveSubscriptionFields < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :url, :title, :description, :image_url, :category_id
  end

  def down
  end
end
