class AddImageUrlAndDescriptionToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :image_url, :string
    add_column :subscriptions, :description, :text
  end
end
