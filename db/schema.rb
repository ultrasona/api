# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_250_326_130_443) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'booking_prestations', id: false, force: :cascade do |t|
    t.bigint 'prestation_id', null: false
    t.bigint 'booking_id', null: false
  end

  create_table 'bookings', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'name', null: false
    t.datetime 'starts_at', null: false
    t.string 'address', null: false
    t.decimal 'lat', null: false
    t.decimal 'lng', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'prestation_by_pro', id: false, force: :cascade do |t|
    t.bigint 'prestation_id', null: false
    t.bigint 'pro_id', null: false
  end

  create_table 'prestations', force: :cascade do |t|
    t.integer 'duration', null: false
    t.string 'reference', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'pros', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'address', null: false
    t.decimal 'lat', null: false
    t.decimal 'lng', null: false
    t.integer 'max_kilometers'
    t.string 'opening_hours', default: [], null: false, array: true
    t.string 'appointments', default: [], null: false, array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
