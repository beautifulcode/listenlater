class AddUidToSeries < ActiveRecord::Migration
  def change
    add_column :series, :uid, :string
    add_index :series, :uid
  end
end
