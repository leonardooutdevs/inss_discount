FactoryBot.define do
  factory :city do
    state
    name { 'São Paulo' }
    ibge_code { '123' }
  end
end
