class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.year :integer
      t.model :string #3500 Chevy HD
      t.nick_name :string #red chevy
      t.timestamps
    end
  end
end
