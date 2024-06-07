class User < ApplicationRecord
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
  )

  has_many :user_accesses, dependent: :destroy
  has_many :access_permission_levels, through: :user_accesses

  validates :email, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[email]
  end
end
