# == Schema Information
#
# Table name: pros
#
#  id             :bigint           not null, primary key
#  name           :string           not null
#  address        :string           not null
#  lat            :decimal(, )      not null
#  lng            :decimal(, )      not null
#  max_kilometers :integer
#  opening_hours  :string           default([]), not null, is an Array
#  appointments   :string           default([]), not null, is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Pro < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :max_kilometers, presence: true
  validates :opening_hours, presence: true
  validates :appointments, presence: true

  has_and_belongs_to_many :prestations, class_name: 'Prestation', join_table: 'prestation_by_pro',
                                        association_foreign_key: 'prestation_id'

  scope :with_prestation, ->(reference) { joins(:prestations).where('reference = ?', reference) }

  def self.find_pros(references, address)
    presta_pro = with_prestations_matching(references)
    within_range_of(presta_pro, address)
  end

  def self.with_prestations_matching(references)
    pros = Pro.with_prestation(references[0])
    available_pros = []

    pros.each do |pro|
      has_prestation = true
      has_prestation = false unless (pro.prestations.map(&:reference) & references) == references

      available_pros.push(pro) if has_prestation
    end

    available_pros
  end

  def self.within_range_of(pros, address)
    address_services = address_coordinates(address)

    available_pros = []
    pros.each do |pro|
      address_pro = address_coordinates(pro.address)

      distance = Geocoder::Calculations.distance_between(address_services, address_pro, units: :km)
      available_pros.push(pro) if distance <= pro.max_kilometers
    end

    available_pros
  end

  def self.address_coordinates(address)
    Geocoder.search(address).first.coordinates
  end
end
