class AddStartDateAndEndDateToProjects < ActiveRecord::Migration[8.1]
  def change
    remove_column :projects, :date
    add_column :projects, :date_started, :date
    add_column :projects, :date_ended, :date
  end
end
