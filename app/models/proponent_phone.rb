class ProponentPhone < ApplicationRecord
  belongs_to :proponent
  belongs_to :phone

  accepts_nested_attributes_for :phone

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  enum kinds: {
    residential: 'residential',
    commercial: 'commercial'
  }
end
