class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title
      t.string :url
      t.text :description
      t.string :image_url
      t.integer :category_id

      t.timestamps
    end
  end
end
