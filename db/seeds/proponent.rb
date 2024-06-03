require 'faker'

module Seeds
  class Proponent
    class << self
      def import
        return if ::Proponent.exists?

        create_salaries unless Salary.exists?

        State.all.each do |state|
          Salary.all.each do |salary|
            rand(2..9).times do
              proponent = create_proponent(state, salary)
              puts "Proponent created: ##{proponent.id} - #{proponent.name}"
            end
          end
        end
      end

      private


      def create_proponent(state, salary)
        address = create_address(state)
        phone = create_phone
        proponent = ::Proponent.create!(
          gross_salary: Faker::Number.between(from: salary.min_amount, to: salary.max_amount),
          name: Faker::Name.name,
          document: Faker::IdNumber.brazilian_citizen_number,
          birth_date: Faker::Date.between(from: '1930-01-01', to: '2002-01-01')
        )

        proponent.addresses << address
        proponent.phones << phone

        proponent
      end

      def create_address(state)
        ::Address.create!(
          city: state.cities.sample,
          address: Faker::Address.street_name,
          number: Faker::Address.building_number,
          complement: Faker::Address.secondary_address,
          neighborhood: Faker::Address.community,
          zip_code: Faker::Address.zip_code
        )
      end

      def create_phone
        ::Phone.create!(number: Faker::PhoneNumber.phone_number)
      end

      def create_salaries
        ::Salary.active.create(
          salary_range: 'Até R$ 1.045,00',
          max_amount: 1045.00,
          min_amount: 0,
          calculation_basis: 0.075
        )

        ::Salary.active.create(
          salary_range: 'De R$ 1.045,01 a R$ 2.089,60',
          max_amount: 2089.60,
          min_amount: 1045.01,
          calculation_basis: 0.09
        )

        ::Salary.active.create(
          salary_range: 'De R$ 2.089,61 até R$ 3.134,40 ',
          max_amount:  3134.40,
          min_amount: 2089.61,
          calculation_basis: 0.12
        )

        ::Salary.active.create(
          salary_range: 'De R$ 3.134,41 até R$ 6.101,06',
          max_amount: 999999999,
          min_amount: 3134.41,
          calculation_basis: 0.14
        )
      end
    end
  end
end
