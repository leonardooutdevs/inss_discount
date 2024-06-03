class State < ApplicationRecord
  paginates_per 15

  belongs_to :country
  has_many :cities, dependent: :destroy

  validates :ibge_code, :name, :uf, presence: true
  validates :name, uniqueness: { scope: :country_id }

  default_scope -> { order(:name) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name uf]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[cities state country]
  end
end
