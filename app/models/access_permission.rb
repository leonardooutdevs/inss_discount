class AccessPermission < ApplicationRecord
  paginates_per 25

  has_many :access_permission_levels, dependent: :destroy
  has_many :access_levels, through: :access_permission_levels

  validates :name, presence: true, length: { maximum: 64 }
  validates :model, presence: true, length: { maximum: 64 }, uniqueness: true

  validate :constantizable_model

  def self.ransackable_attributes(_auth_object = nil)
    %w[name model]
  end

  private

  def constantizable_model
    Rails.application.eager_load!
    valid = ApplicationRecord.descendants.include?(model.to_s.classify.safe_constantize)

    errors.add(:model, :invalid_constantizable_model) unless valid
  end
end
