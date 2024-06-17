FactoryBot.define do
  factory :access_level do
    name { 'superadmin' }
    kind { 'superadmin' }

    initialize_with do
      AccessLevel.find_or_create_by(name:, kind:)
    end
  end
end
