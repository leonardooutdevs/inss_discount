require 'rails_helper'

RSpec.describe 'Users' do
  before { sign_in(create(:user)) }

  describe 'GET /index' do
    subject(:get_index) { get('/users', params:) }

    let(:params) { {} }

    context 'when successful' do
      it_behaves_like 'a request'
      it { get_index and expect(response).to render_template :index }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_user_path(user, format: :turbo_stream) }

      let(:user) { create(:user) }

      it_behaves_like 'a request'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get user_path(user, format: :turbo_stream) }

      let(:user) { create(:user) }

      it_behaves_like 'a request'
      it { get_show and expect(response).to render_template :_user }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch user_path(user), params: }

    let(:user) { create(:user) }
    let(:params) { { user: attributes_for(:user), format: :turbo_stream } }

    it_behaves_like 'a request'
    it { expect { patch_update and user.reload }.to change(user, :attributes) }

    context 'when validation fails' do
      let(:params) { { user: { email: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and user.reload }.not_to change(user, :attributes) }
    end
  end
end
