class AddSlugToSeriesAndSource < ActiveRecord::Migration
  def change
    add_column :series, :slug, :string
    add_index :series, :slug, unique: true

    add_column :sources, :slug, :string
    add_index :sources, :slug, unique: true
  end
end
