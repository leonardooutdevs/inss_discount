module Users
  class AccessPermissionLevelsController < ResourcefulController
    resourceful(
      only: :index,
      turbo: true,
      scope: :user,
      scopes: :with_access_permission,
      columns: %(
      access_permission_levels.*
      , access_permissions.name
      , access_permissions.model
      ),
      order: 'access_permissions.name asc'
    )
  end
end
