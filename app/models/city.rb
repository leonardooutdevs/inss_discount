class City < ApplicationRecord
  paginates_per 15

  belongs_to :state
  has_many :addresses, dependent: :destroy

  validates :name, presence: true
end
