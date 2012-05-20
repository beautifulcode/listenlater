class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
