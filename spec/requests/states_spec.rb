require 'rails_helper'

RSpec.describe 'States' do
  before { sign_in(create(:user)) }

  describe 'GET /index' do
    subject(:get_index) { get('/states', params:) }

    let(:params) { {} }

    context 'when successful' do
      it_behaves_like 'a request'
      it { get_index and expect(response).to render_template :index }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_state_path(state, format: :turbo_stream) }

      let(:state) { create(:state) }

      it_behaves_like 'a request'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get state_path(state, format: :turbo_stream) }

      let(:state) { create(:state) }

      it_behaves_like 'a request'
      it { get_show and expect(response).to render_template :_state }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch state_path(state), params: }

    let(:state) { create(:state) }
    let(:params) { { state: { name: 'Canada' }, format: :turbo_stream } }

    it_behaves_like 'a request'
    it { expect { patch_update and state.reload }.to change(state, :attributes) }

    context 'when validation fails' do
      let(:params) { { state: { name: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and state.reload }.not_to change(state, :name) }
    end
  end
end
