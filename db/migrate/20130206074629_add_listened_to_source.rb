class AddListenedToSource < ActiveRecord::Migration
  def change
    add_column :sources, :listened, :boolean, :default => false, :index => true
  end
end
