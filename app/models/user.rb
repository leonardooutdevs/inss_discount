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
  has_many :access_levels, through: :access_permission_levels
  has_many :access_permissions, through: :access_permission_levels

  validates :email, presence: true, uniqueness: true

  after_create -> { Users::CreateDefaultPermissionsJob.perform_later(id) if access_permission_levels.empty? }

  def self.ransackable_attributes(_auth_object = nil)
    %w[email]
  end
end
