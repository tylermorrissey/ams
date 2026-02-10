class AddProjectsTable < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |table|
      table.string :customer_name
      table.date :date
      table.string :address
      table.text :desc #install a retaining wall and cut down a tree``
      table.string :job_type #retaining wall, trim-edge-mulch, seed
      table.integer :estimates #init estimate cost
      table.float :net_cost #what did it cost with all materials included
      table.string :employees #who worked on the job
      table.text :materials #what was used. Lbs of preen, fert, gas, plants
      table.float :hours_onsite #total hours of everyone on the job
      table.text :equipment_onsite #loader, trucks, escavator, etc
      
      table.timestamps
    end
  end
end
