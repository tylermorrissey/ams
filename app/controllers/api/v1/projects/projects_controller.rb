require 'date'
class ProjectsController < ApplicationController
  ActiveRecord::Schema[].Migration[8.1]
  def create
    create_table :projects do |table|
      table.string :customer_Lname
      table.date :date
      table.string :address
      table.text :desc #install a retaining wall and cut down a tree
      table.string :job_type #retaining wall, trim-edge-mulch, seed
      table.integer :estimates #init estimate cost
      table.double :net_cost #what did it cost with all materials included
      table.string :employees #who worked on the job
      table.string :materials #what was used. Lbs of preen, fert, gas, plants
      table.string :hours_onsite #total hours on the job
      table.string :equipment_onsite #loader, trucks, escavator, etc
      
      table.timestamps
    end
  end
end