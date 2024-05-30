class Salary < ApplicationRecord
  enum status: {
    actives: 'actives',
    inactives: 'inactives'
  }

  default_scope { actives }
end
