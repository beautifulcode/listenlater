class AddDurationToSource < ActiveRecord::Migration
  def change
    add_column :sources, :duration, :string
  end
end
