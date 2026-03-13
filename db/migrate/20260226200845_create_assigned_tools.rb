class CreateAssignedTools < ActiveRecord::Migration[8.1]
  def change
    create_table :assigned_tools do |t|
      t.float :hours_onsite
      t.references :project, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true
      t.timestamps
    end
  end
end
