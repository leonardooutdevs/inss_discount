class Address < ApplicationRecord
  belongs_to :city
  has_one :state, through: :city
  has_one :country, through: :city

  validates :address, :neighborhood, :zip_code, presence: true
  validates :address, uniqueness: { scope: %i[city_id number complement neighborhood zip_code] }

  delegate :id, to: :state, prefix: true, allow_nil: true
end
