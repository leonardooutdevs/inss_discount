class Country < ApplicationRecord
  BRAZIL = 'Brasil'.freeze

  scope :brazil, -> { find_by(name: BRAZIL) }

  has_many :states, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
