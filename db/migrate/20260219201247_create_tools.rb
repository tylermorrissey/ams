class CreateTools < ActiveRecord::Migration[8.1]
  def change
    create_table :tools do |t|
      t.string :name
      t.string :make
      t.string :model
      t.integer :serial_number
      t.date :purchase_date
      t.integer :project_id
      t.timestamps
    end
  end
end
