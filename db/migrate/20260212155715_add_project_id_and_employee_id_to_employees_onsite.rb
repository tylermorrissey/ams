class AddProjectIdAndEmployeeIdToAssignment < ActiveRecord::Migration[8.1]
  def change
  add_reference :assignments, :project, foreign_key: true
  add_reference :assignments, :project, foreign_key: true
  end
end
