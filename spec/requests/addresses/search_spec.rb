require 'rails_helper'

RSpec.describe 'Proponents::Reports' do
  before do
    sign_in(create(:user))
  end

  describe 'GET /index' do
    subject(:get_index) { get(addresses_search_path, params:) }

    let(:params) { { zip_code: address.zip_code } }
    let(:address) { create(:address, :mogi) }

    let(:expected_response) do
      {
        'city_id' => a_kind_of(String),
        'city' => a_kind_of(String),
        'state_id' => a_kind_of(String),
        'state' => a_kind_of(String),
        'country_id' => a_kind_of(String),
        'neighborhood' => a_kind_of(String),
        'address' => a_kind_of(String),
        'complement' => a_kind_of(String)
      }
    end

    before do
      allow(Addresses::Fetch).to receive(:call).and_call_original
      allow(Brazil::Cep).to receive(:fetch).and_call_original

      stub_request(:get, /#{address.zip_code}/)
        .to_return(
          body: file_fixture('addresses/payload.json').read,
          status: 200
        )
    end

    it_behaves_like 'a request'

    it { get_index and expect(Addresses::Fetch).to have_received(:call).at_least(1) }
    it { get_index and expect(Brazil::Cep).to have_received(:fetch).at_least(1) }
    it { get_index and expect(json_response).to include(expected_response) }
  end
end
