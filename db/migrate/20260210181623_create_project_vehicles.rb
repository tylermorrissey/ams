class CreateProjectVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :project_vehicles do |t|
      t.timestamps
    end
  end
end
