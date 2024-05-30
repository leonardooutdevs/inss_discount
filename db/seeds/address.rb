require 'csv'

module Seeds
  class Address
    class << self
      def import
        seed_countries
        seed_states
        seed_cities
      end

      private

      def seed_countries
        return if Country.exists?

        Country.create!(name: Country::BRAZIL)
      end

      def seed_states
        return if State.exists?

        file = File.read(Rails.root.join('db', 'seeds', 'address', 'states.csv'))
        csv = CSV.parse(file, headers: true)

        csv.each do |row|
          State.create!(
            name: row['NOME'].strip,
            uf: row['SIGLA'].strip,
            ibge_code: row['COD'].strip,
            country: Country.brazil
          )
        end
      end

      def seed_cities
        return if City.exists?

        file = File.read(Rails.root.join('db', 'seeds', 'address', 'cities.csv'))
        csv = CSV.parse(file, headers: true)
        states = {}

        csv.each do |row|
          name = row['NOME'].strip
          uf_ibge_code = row['COD UF'].strip
          ibge_code = row['COD'].strip

          states[uf_ibge_code] ||= State.find_by(ibge_code: uf_ibge_code)
          puts "=== add [#{uf_ibge_code} - #{states[uf_ibge_code].uf}] to pool" unless states[uf_ibge_code].nil?

          next if states[uf_ibge_code].nil?

          states[uf_ibge_code].cities.create!(
            name: name,
            ibge_code: ibge_code
          )
        end
      end
    end
  end
end
