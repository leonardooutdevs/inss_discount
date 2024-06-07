class AccessPermissionLevel < ApplicationRecord
  belongs_to :access_permission
  belongs_to :access_level
  validates :access_permission_id, uniqueness: { scope: :access_level_id }
end
