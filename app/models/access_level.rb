class AccessLevel < ApplicationRecord
  validates :name, presence: true, length: { maximum: 64 }
  validates :kind, presence: true, length: { maximum: 64 }, uniqueness: true

  scope :read,        -> { find_by(kind: 'read') }
  scope :write,       -> { find_by(kind: 'write') }
  scope :admin,       -> { find_by(kind: 'admin') }
  scope :superadmin,  -> { find_by(kind: 'superadmin') }
  scope :order_by_kind, lambda {
    order(Arel.sql("CASE WHEN kind = 'read' THEN '1'
      WHEN kind = 'write' THEN '2'
      WHEN kind = 'admin' THEN '3'
      WHEN kind = 'superadmin' THEN '4'
    END"))
  }
end
