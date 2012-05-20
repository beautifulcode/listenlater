class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
