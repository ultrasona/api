class CreateBookingPrestations < ActiveRecord::Migration[7.1]
  def change
    create_join_table(:prestation, :booking, table_name: 'booking_prestations')
  end
end
