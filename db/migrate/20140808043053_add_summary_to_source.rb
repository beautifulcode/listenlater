class AddSummaryToSource < ActiveRecord::Migration
  def change
    add_column :sources, :summary, :text
  end
end
