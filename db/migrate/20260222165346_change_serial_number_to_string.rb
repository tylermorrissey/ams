class ChangeSerialNumberToString < ActiveRecord::Migration[8.1]
  def change
    change_column :tools, :serial_number, :string
  end
end
