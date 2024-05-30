FactoryBot.define do
  factory :address do
    city
    address { Faker::Address.street_name }
    number { Faker::Address.building_number }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    zip_code { Faker::Address.zip_code }
  end
end
