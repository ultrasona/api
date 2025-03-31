class FindAvailablePros
  def initialize(references, address)
    @references = references
    @address = address
  end

  def call
    pros = @references.present? ? pros_with_prestations_matching : nil
    pros_within_range_of(pros)
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
end
