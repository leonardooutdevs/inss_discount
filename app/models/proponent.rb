class Proponent < ApplicationRecord
  paginates_per 5

  belongs_to :salary

  has_many :proponent_addresses, dependent: :destroy
  has_many :addresses, through: :proponent_addresses

  has_many :proponent_phones, dependent: :destroy
  has_many :phones, through: :proponent_phones

  accepts_nested_attributes_for :proponent_addresses, allow_destroy: true
  accepts_nested_attributes_for :addresses, allow_destroy: true

  accepts_nested_attributes_for :proponent_phones, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true

  validates(
    :name,
    :gross_salary,
    :discount,
    :net_salary,
    :document,
    :birth_date,
    presence: true
  )

  validates :document, uniqueness: true, format: { with: /\A\d+\z/, case_sensitive: false }

  before_validation :calculate_discount, if: :gross_salary_changed?
  before_validation lambda {
    self.salary = Salary.find_by('min_amount <= ? AND max_amount >= ?', gross_salary, gross_salary)
  }

  def calculate_discount = Discount.call(self)

  def self.ransackable_attributes(_auth_object = nil)
    %w[name document]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[addresses phones]
  end
end
