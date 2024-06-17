FactoryBot.define do
  factory :user_access do
    user
    access_permission_level
  end
end
