FactoryBot.define do
  factory :state do
    country
    name { 'São Paulo' }
    uf { 'SP' }
    ibge_code { '123' }
  end
end
