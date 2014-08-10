class AddCategoryIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :category_id, :integer
  end
end
