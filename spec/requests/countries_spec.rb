require 'rails_helper'

RSpec.describe 'Countries' do
  before { sign_in(create(:user)) }

  describe 'GET /index' do
    subject(:get_index) { get('/countries', params:) }

    let(:params) { {} }

    context 'when successful' do
      it_behaves_like 'a request'
      it { get_index and expect(response).to render_template :index }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_country_path(country) }

      let(:country) { create(:country) }

      it_behaves_like 'a request'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get country_path(country) }

      let(:country) { create(:country) }

      it_behaves_like 'a request'
      it { get_show and expect(response).to render_template :_country }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch country_path(country), params: }

    let(:country) { create(:country) }
    let(:params) { { country: { name: 'Canada' }, format: :turbo_stream } }

    it_behaves_like 'a request'
    it { expect { patch_update and country.reload }.to change(country, :attributes) }

    context 'when validation fails' do
      let(:params) { { country: { name: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and country.reload }.not_to change(country, :attributes) }
    end
  end
end
