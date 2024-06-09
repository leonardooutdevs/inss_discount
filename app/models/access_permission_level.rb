class AccessPermissionLevel < ApplicationRecord
  belongs_to :access_permission
  belongs_to :access_level

  has_many :user_accesses, dependent: :destroy

  validates :access_permission_id, uniqueness: { scope: :access_level_id }

  scope :default, -> { joins(:access_level).find_by(access_levels: { kind: 'default' }) }
  scope :read, -> { joins(:access_level).find_by(access_levels: { kind: 'read' }) }
  scope :write, -> { joins(:access_level).find_by(access_levels: { kind: 'write' }) }
  scope :admin, -> { joins(:access_level).find_by(access_levels: { kind: 'admin' }) }
  scope :superadmin, -> { joins(:access_level).find_by(access_levels: { kind: 'superadmin' }) }
  scope :with_access_permission, -> { eager_load({ access_permission: :access_levels }, :access_level) }
  scope :by, ->(model) { with_access_permission.find_by(access_permission: { model: }) }

  delegate :name, :model, :access_levels, to: :access_permission
  delegate :kind, to: :access_level

  def read? = kind != 'default'
  def write? = %w[default read].exclude?(kind)
  def admin? = %w[default read write].exclude?(kind)
  def superadmin? = kind == 'superadmin'
end
