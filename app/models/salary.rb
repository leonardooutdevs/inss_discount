class Salary < ApplicationRecord
  has_many :proponents, dependent: :nullify

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  validates :salary_range, :max_amount, :min_amount, :calculation_basis, :status, presence: true
  validates :salary_range, uniqueness: { scope: :calculation_basis }

  default_scope { active }

  def self.ransackable_attributes(_auth_object = nil)
    %w[salary_range]
  end
end
