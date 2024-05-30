class Country < ApplicationRecord
  BRAZIL = 'Brasil'.freeze

  scope :brazil, -> { find_by(name: BRAZIL) }

  has_many :states, dependent: :destroy

  validates :name, presence: true
end
