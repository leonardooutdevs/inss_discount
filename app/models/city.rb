class City < ApplicationRecord
  paginates_per 15

  belongs_to :state
  has_one :country, through: :state
  has_many :addresses, dependent: :destroy

  validates :name, presence: true

  default_scope -> { order(:name) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name uf]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[state country]
  end
end
