class Salary < ApplicationRecord
  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  default_scope { active }
end
