class MakeAppoint < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :hospital
      t.date :date
      t.time :time
      t.string :reason

      t.timestamps null: false
    end
  end
end
