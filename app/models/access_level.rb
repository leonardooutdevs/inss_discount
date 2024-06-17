class AccessLevel < ApplicationRecord
  has_many :access_permission_levels, dependent: :destroy

  validates :name, presence: true, length: { maximum: 64 }
  validates :kind, presence: true, length: { maximum: 64 }, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name kind]
  end
end
