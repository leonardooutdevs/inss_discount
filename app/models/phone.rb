class Phone < ApplicationRecord
  validates :number, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[number]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
