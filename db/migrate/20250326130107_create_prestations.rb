class CreatePrestations < ActiveRecord::Migration[7.1]
  def change
    create_table :prestations do |t|
      t.integer :duration, null: false
      t.string :reference, null: false
      t.timestamps
    end
  end
end
