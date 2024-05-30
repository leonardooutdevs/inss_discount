class State < ApplicationRecord
  paginates_per 15

  belongs_to :country
  has_many :cities, dependent: :destroy

  validates :name, presence: true
end
