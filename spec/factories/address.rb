FactoryBot.define do
  factory :address do
    city
    address { Faker::Address.street_name }
    number { Faker::Address.building_number }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    zip_code { Faker::Address.zip_code }

    trait :mogi do
      city factory: %i[city mogi]
      zip_code { '13844226' }
    end
  end
end
