require 'rails_helper'

RSpec.describe 'Dashboard::Proponents' do
  before { sign_in(create(:user)) }

  describe 'GET /index' do
    subject(:get_index) { get('/proponents', params:) }

    let(:params) { {} }

    context 'when successful' do
      it_behaves_like 'a request'
      it { get_index and expect(response).to render_template :index }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_proponent_path(proponent) }

      let(:proponent) { create(:proponent) }

      it_behaves_like 'a request'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get proponent_path(proponent) }

      let(:proponent) { create(:proponent) }

      it_behaves_like 'a request'
      it { get_show and expect(response).to render_template :_proponent }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch proponent_path(proponent), params: }

    let(:proponent) { create(:proponent) }
    let(:params) { { proponent: attributes_for(:proponent), format: :turbo_stream } }

    it_behaves_like 'a request'
    it { expect { patch_update and proponent.reload }.to change(proponent, :attributes) }

    context 'when validation fails' do
      let(:params) { { proponent: { name: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and proponent.reload }.not_to change(proponent, :attributes) }
    end
  end
end
