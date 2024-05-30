class Proponent < ApplicationRecord
  paginates_per 5

  belongs_to :address
  belongs_to :phone
  belongs_to :salary

  validates :name, presence: true
end
