class CreateListens < ActiveRecord::Migration
  def change
    create_table :listens do |t|
      t.integer :source_id
      t.integer :user_id
      t.string :start_time
      t.string :finish_time
      t.string :client

      t.timestamps
    end
  end
end
