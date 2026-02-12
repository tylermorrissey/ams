class DropEmployeesOnsite < ActiveRecord::Migration[8.1]
  def change
    drop_table :employees_onsites
  end
end
