class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.datetime :starts_at, null: false
      t.string :address, null: false
      t.decimal :lat, null: false
      t.decimal :lng, null: false
      t.timestamps
    end
  end
end
