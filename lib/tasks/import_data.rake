desc 'Fills database with the data from data.json'
namespace :importation do
  task :imports_data do
    sections = JSON.parse(File.read('vendor/data.json'))

    sections['prestations'].each do |prestation|
      Prestation.create!(prestation)
      puts "Prestation #{Prestation.last.reference} added to database"
    end

    sections['pros'].each do |pro|
      prestations = pro['prestations'].map do |prestation|
        Prestation.find_by(reference: prestation)
      end

      Pro.create!(
        name: pro['name'],
        address: pro['address'],
        lat: pro['lat'],
        lng: pro['lng'],
        max_kilometers: pro['max_kilometers'],
        opening_hours: pro['opening_hours'],
        appointments: pro['appointments'],
        prestations: prestations
      )

      puts "Pro #{Pro.last.name} added to database"
    end

    sections['bookings'].each do |booking|
      prestations = booking['prestations'].map do |prestation|
        Prestation.find_by(reference: prestation)
      end

      Booking.create!(
        email: booking['email'],
        name: booking['name'],
        starts_at: booking['starts_at'],
        address: booking['address'],
        lat: booking['lat'],
        lng: booking['lng'],
        prestations: prestations
      )

      puts "Booking for #{Booking.last.name} added to database"
    end

    puts 'The database is now fully filled with the datas from data.json'
  end
end
