class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :subscription_count

      t.timestamps
    end
  end
end
