class FindAvailablePros
  def initialize(references, address, rdv_date, rdv_time)
    @references = references
    @address = address
    @rdv_date = rdv_date
    @rdv_time = rdv_time
  end

  def call
    pros_with_reference = @references.present? ? pros_with_prestations_matching : nil
    pros_within_range_of(pros_with_reference) &
      pros_open_at(pros_with_reference) &
      pros_available_at(pros_with_reference)
  end

  private

  def pros_with_prestations_matching
    pros = Pro.with_prestation(@references[0])
    available_pros = []

    pros.each do |pro|
      has_prestation = true
      has_prestation = false unless (pro.prestations.map(&:reference) & @references) == @references

      available_pros.push(pro) if has_prestation
    end
    available_pros
  end

  def pros_within_range_of(pros)
    address_services = address_coordinates(@address)
    available_pros   = []

    pros.each do |pro|
      distance = Geocoder::Calculations.distance_between(address_services, [pro.lat, pro.lng], units: :km)
      available_pros.push(pro) if distance <= pro.max_kilometers
    end

    available_pros
  end

  def address_coordinates(address)
    Geocoder.search(address).first.coordinates
  end

  def pros_open_at(pros)
    rdv_day = Date.parse(@rdv_date).strftime('%A').downcase
    available_pros = []

    pros.each do |pro|
      pro.opening_hours.each do |opening_hours_by_day|
        opening_hours_by_day = JSON.parse opening_hours_by_day.gsub('=>', ':')

        next unless rdv_day == opening_hours_by_day['day']

        between_opening_time?(opening_hours_by_day) ? available_pros.push(pro) : nil
      end
    end

    available_pros
  end

  def between_opening_time?(opening_hours_by_day)
    (opening_hours_by_day['starts_at'] >= @rdv_time) &&
      (@rdv_time <= opening_hours_by_day['ends_at'])
  end

  def pros_available_at(pros)
    required_appointment = format_required_appointment
    available_pros = []

    pros.each do |pro|
      is_available = true
      pro.appointments.each do |appointment|
        is_available = available?(appointment, required_appointment)
        next unless is_available
      end

      is_available ? available_pros.push(pro) : nil
    end

    available_pros
  end

  def format_required_appointment
    rdv_month, rdv_day, rdv_year = @rdv_date.split('-')[1..2].push(@rdv_date.split('-')[0])
    rdv_time_str = Time.parse(@rdv_time).strftime('%I:%M %p')
    formatted_date_time = "#{rdv_month}/#{rdv_day}/#{rdv_year} #{rdv_time_str}"
    DateTime.strptime(formatted_date_time, '%m/%d/%Y %I:%M %p')
  end

  def available?(appointment, required_appointment)
    appoitment_hash = JSON.parse appointment.gsub('=>', ':')
    !required_appointment.between?(appoitment_hash['starts_at'].to_datetime, appoitment_hash['ends_at'].to_datetime)
  end
end
