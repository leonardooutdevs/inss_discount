FactoryBot.define do
  factory :proponent do
    address
    phone
    salary

    gross_salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    discount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    net_salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    name { Faker::Name.name }
    document { Faker::IdNumber.brazilian_citizen_number }
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2002-01-01') }
  end
end
