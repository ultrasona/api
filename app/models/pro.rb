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
end
