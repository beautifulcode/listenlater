class AddSeriesIdToSource < ActiveRecord::Migration
  def change
    add_column :sources, :series_id, :integer
    add_index :sources, :series_id
  end
end
