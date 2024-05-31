require 'faker'

module Seeds
  class Proponent
    class << self
      def import
        return if ::Proponent.exists?

        create_salaries unless Salary.exists?

        10.times do
          proponent = create_proponent
          puts "Proponent created: ##{proponent.id} - #{proponent.name}"
        end
      end

      private


      def create_proponent
        address = create_address
        phone = create_phone
        ::Proponent.create!(
          address: address,
          phone: phone,
          gross_salary: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          discount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
          net_salary: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          name: Faker::Name.name,
          document: Faker::IdNumber.brazilian_citizen_number, # or generate a valid CPF
          birth_date: Faker::Date.between(from: '1930-01-01', to: '2002-01-01')
        )
      end

      def create_address
        city = City.first # adicione a logica para selecionar a cidade
        ::Address.create!(
          city: city,
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
        ::Salary.actives.create(
          salary_range: 'Até R$ 1.045,00',
          max_amount: 1045.00,
          min_amount: 0,
          calculation_basis: 0.075
        )

        ::Salary.actives.create(
          salary_range: 'De R$ 1.045,01 a R$ 2.089,60',
          max_amount: 2089.60,
          min_amount: 1045.01,
          calculation_basis: 0.09
        )

        ::Salary.actives.create(
          salary_range: 'De R$ 2.089,61 até R$ 3.134,40 ',
          max_amount:  3134.40,
          min_amount: 2089.61,
          calculation_basis: 0.12
        )

        ::Salary.actives.create(
          salary_range: 'De R$ 3.134,41 até R$ 6.101,06',
          max_amount: 0,
          min_amount: 3134.41,
          calculation_basis: 0.14
        )
      end
    end
  end
end
