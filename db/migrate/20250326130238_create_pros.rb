class CreatePros < ActiveRecord::Migration[7.1]
  def change
    create_table :pros do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.decimal :lat, null: false
      t.decimal :lng, null: false
      t.integer :max_kilometers
      t.string :opening_hours, array: true, null: false, default: []
      t.string :appointments, array: true, null: false, default: []

      t.timestamps
    end
  end
end
