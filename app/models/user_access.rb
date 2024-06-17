class UserAccess < ApplicationRecord
  belongs_to :user
  belongs_to :access_permission_level

  has_one :access_permission, through: :access_permission_level
end
