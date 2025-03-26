# == Schema Information
#
# Table name: prestations
#
#  id         :bigint           not null, primary key
#  duration   :integer          not null
#  reference  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Prestation < ApplicationRecord
  validates :reference, uniqueness: true, presence: true
  validates :duration, presence: true

  has_and_belongs_to_many :pros, class_name: 'Pro', join_table: 'prestation_by_pro', association_foreign_key: 'pro_id'
  has_and_belongs_to_many :bookings, class_name: 'Booking', join_table: 'booking_prestations',
                                     association_foreign_key: 'booking_id'
end
