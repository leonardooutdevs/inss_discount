class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
  )

  validates :email, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[email]
  end
end
