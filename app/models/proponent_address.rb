class ProponentAddress < ApplicationRecord
  belongs_to :proponent
  belongs_to :address

  accepts_nested_attributes_for :address

  validates :kind, :status, presence: true
  validates :proponent_id, uniqueness: { scope: :address_id }

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  enum kinds: {
    residential: 'residential',
    commercial: 'commercial'
  }
end
