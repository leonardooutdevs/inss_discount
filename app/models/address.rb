class Address < ApplicationRecord
  belongs_to :city
  has_one :state, through: :city
  has_one :country, through: :city

  delegate :id, to: :state, prefix: true, allow_nil: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[address number complement neighborhood zip_code]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[city state country]
  end
end
