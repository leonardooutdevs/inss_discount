require 'rails_helper'

RSpec.describe 'Cities' do
  before { sign_in(create(:user)) }

  describe 'GET /index' do
    subject(:get_index) { get('/cities', params:) }

    let(:params) { {} }

    context 'when successful' do
      it_behaves_like 'a request'
      it { get_index and expect(response).to render_template :index }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_city_path(city) }

      let(:city) { create(:city) }

      it_behaves_like 'a request'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get city_path(city) }

      let(:city) { create(:city) }

      it_behaves_like 'a request'
      it { get_show and expect(response).to render_template :_city }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch city_path(city), params: }

    let(:city) { create(:city) }
    let(:params) { { city: { name: 'Canada' }, format: :turbo_stream } }

    it_behaves_like 'a request'
    it { expect { patch_update and city.reload }.to change(city, :attributes) }

    context 'when validation fails' do
      let(:params) { { city: { name: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and city.reload }.not_to change(city, :attributes) }
    end
  end
end
