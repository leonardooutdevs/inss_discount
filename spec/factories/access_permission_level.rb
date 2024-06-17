FactoryBot.define do
  factory :access_permission_level do
    access_permission
    access_level

    initialize_with do
      AccessPermissionLevel.find_or_create_by(access_permission:, access_level:)
    end
  end
end
