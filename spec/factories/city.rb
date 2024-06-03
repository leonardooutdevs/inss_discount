FactoryBot.define do
  factory :city do
    state
    name { 'São Paulo' }
    ibge_code { '123' }

    trait :mogi do
      name { 'Mogi Guaçu' }
      state factory: %i[state], name: 'São Paulo', uf: 'SP'
    end
  end
end
