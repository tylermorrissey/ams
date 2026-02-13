class AddAssignmentTable < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.references :employee, foreign_key: true
      t.references :project, foreign_key: true
      t.float :hours_onsite 
      t.timestamps
    end
  end
end
