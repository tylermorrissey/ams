class CreateEmployeesOnsites < ActiveRecord::Migration[8.1]
  def change
    create_table :employees_onsites do |t|
      t.customer_name :string
      t.employee_name :string
      t.hours_onsite :float
      t.timestamps
    end
  end
end
