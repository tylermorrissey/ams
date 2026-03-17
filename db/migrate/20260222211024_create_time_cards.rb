class CreateTimeCards < ActiveRecord::Migration[8.1]
  def change
    create_table :time_cards do |t|
      t.timestamp :clock_in, null: false
      t.timestamp :clock_out
      t.date :date, null: false
      t.references :employee, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
