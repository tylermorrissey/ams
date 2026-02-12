class AddProjectIdAndEmployeeIdToAssignment < ActiveRecord::Migration[8.1]
  def change
    add_column :assignments, :employee_id, :references
    add_column :assignmentss, :project_id, :references
  end
end
