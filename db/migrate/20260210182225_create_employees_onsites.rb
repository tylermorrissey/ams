class CreateEmployeesOnsites < ActiveRecord::Migration[8.1]
  def change
    create_table :employees_onsites do |t|
      t.string :customer_name
      t.string :employee_name
      t.float :hours_onsite
      t.timestamps
    end
  end
end
