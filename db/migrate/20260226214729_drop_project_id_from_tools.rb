class DropProjectIdFromTools < ActiveRecord::Migration[8.1]
  def change
    remove_column :tools, :project_id, :integer
  end
end
