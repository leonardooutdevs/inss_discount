module Addresses
  class Fetch < ApplicationService
    def initialize(zip_code)
      @zip_code = zip_code
    end

    def call
      fetch_data
      fetch_state

      response
    end

    private

    attr_reader :zip_code, :data, :state

    delegate :cities, to: :state, allow_nil: true
    delegate :city, to: :data, allow_nil: true

    def fetch_data
      @data = Brazil::Cep.fetch(zip_code)
    end

    def fetch_state
      @state = State.find_by(uf: data.state)
    end

    def response
      {
        **city_info,
        **state_info,
        country_id: state.country_id,
        **address_info
      }
    end

    def city_info
      {
        city_id: cities.find_by(name: city)&.id,
        city:
      }
    end

    def state_info
      {
        state_id: state.id,
        state: state.name
      }
    end

    def address_info
      {
        neighborhood: data.neighborhood,
        address: data.street,
        complement: data.complement
      }
    end
  end
end
