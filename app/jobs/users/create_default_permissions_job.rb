module Users
  class CreateDefaultPermissionsJob < ApplicationJob
    queue_as :users

    def perform(user_id)
      user = User.find(user_id)
      AccessPermission.find_each do |access_permission|
        apl = access_permission.access_permission_levels.default
        apls = user.access_permission_levels
        apls << apl unless apls.include?(apl)
      end
    end
  end
end
