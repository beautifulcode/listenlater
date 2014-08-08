class AddXmlToSource < ActiveRecord::Migration
  def change
    add_column :sources, :xml, :text
  end
end
