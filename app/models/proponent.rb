class Proponent < ApplicationRecord
  paginates_per 5

  belongs_to :address
  belongs_to :phone

  validates(
    :name,
    :gross_salary,
    :discount,
    :net_salary,
    :document,
    :birth_date,
    presence: true
  )

  validates :document, uniqueness: true, format: { with: /\A\d+\z/ }

  before_validation :calculate_discount

  def calculate_discount = Discount.call(self)
end
