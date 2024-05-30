FactoryBot.define do
  factory :salary do
    salary_range { 'Até R$ 1.045,00' }
    status { 'actives' }
    max_amount { 1045.00 }
    min_amount { 0 }
    calculation_basis { 7.5 }
  end
end
