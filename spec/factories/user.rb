FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }

    transient do
      with_accesses { true }
      access_level_kind { 'superadmin' }
    end

    after(:create) do |user, ev|
      if ev.with_accesses
        AccessPermission.find_each do |access_permission|
          user.access_permission_levels << access_permission.access_permission_levels.send(ev.access_level_kind)
        end
      end
    end
  end
end
