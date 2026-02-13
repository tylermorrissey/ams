class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.integer :year
      t.string :model #3500 Chevy HD
      t.string :nick_name #red chevy
      t.timestamps
    end
  end
end
