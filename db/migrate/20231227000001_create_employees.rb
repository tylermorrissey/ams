class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :role, null: false
      t.date :hire_date

      t.timestamps
    end

    add_index :employees, :email, unique: true
  end
end
