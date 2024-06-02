FactoryBot.define do
  factory :salary do
    salary_range { 'Até R$ 1.045,00' }
    status { 'active' }
    max_amount { 1045.00 }
    min_amount { 0 }
    calculation_basis { 0.075 }

    trait :all do
      before(:create) do
        unless Salary.exists?
          create(:salary, min_amount: 1045.01, max_amount: 2089.60, calculation_basis: 0.09)
          create(:salary, min_amount: 2089.61, max_amount: 3134.40, calculation_basis: 0.12)
          create(:salary, min_amount: 3134.41, max_amount: 6101.06, calculation_basis: 0.14)
        end
      end
    end
  end
end
