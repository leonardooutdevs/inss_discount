require 'rails_helper'

RSpec.describe 'Users::Sessions' do
  describe 'GET /login' do
    context 'when new session' do
      subject(:login) { get new_user_session_path }

      it_behaves_like 'a request'
    end

    context 'when is not logged' do
      subject(:login) { get '/users' }

      it_behaves_like 'a request', :found
    end

    context 'when is already logged' do
      subject(:login) { get new_user_session_path }

      before { sign_in(create(:user)) }

      it_behaves_like 'a request', :found
    end
  end

  describe 'GET /signup' do
    context 'when is not logged' do
      subject(:login) { get new_user_registration_path }

      it_behaves_like 'a request'
    end
  end

  describe 'POST /users' do
    context 'when is not logged' do
      subject(:post_create) { post('/users', params:) }

      let(:params) { { user: { email: 'email@email.com', password: 'teste', password_confirmation: 'teste' } } }

      it_behaves_like 'a request', :see_other
      it { expect { post_create }.to change(User, :count) }
      it { post_create and expect(flash[:notice]).to eq(I18n.t('devise.registrations.signed_up')) }
    end
  end
end
