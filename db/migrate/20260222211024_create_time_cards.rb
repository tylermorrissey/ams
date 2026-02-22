class CreateTimeCards < ActiveRecord::Migration[8.1]
  def change
    create_table :time_cards do |t|
      t.time :clock_in, null: false
      t.time :clock_out
      t.references :employee, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
