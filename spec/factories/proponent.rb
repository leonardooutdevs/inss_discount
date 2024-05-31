FactoryBot.define do
  factory :proponent do
    address
    phone

    name { Faker::Name.name }
    gross_salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    document { Faker::IdNumber.brazilian_citizen_number }
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2002-01-01') }
  end
end