# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  starts_at  :datetime         not null
#  address    :string           not null
#  lat        :decimal(, )      not null
#  lng        :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Booking < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true
  validates :starts_at, presence: true
  validates :address, presence: true
  validates :lat, presence: true
  validates :lng, presence: true

  has_and_belongs_to_many :prestations, class_name: 'Prestation', join_table: 'booking_prestations',
                                        association_foreign_key: 'prestation_id'
end
