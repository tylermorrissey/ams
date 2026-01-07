require 'date'
class ProjectsController < ApplicationController
  ActiveRecord::Schema[].Migration[8.1]
  def create
    create_table :projects do |table|
      table.date :date
      table.string :address
      table.text :desc
      table.string :job_type
      table.integer :estimates
      table.double :net_cost

      table.timestamps
    end
  end
end