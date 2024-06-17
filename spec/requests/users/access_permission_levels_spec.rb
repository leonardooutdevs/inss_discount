require 'rails_helper'

RSpec.describe 'Users::AccessPermissionLevels' do
  before { sign_in(user) }

  let(:user) { create(:user) }

  describe 'GET /index' do
    subject(:get_index) { get(user_access_permission_levels_path(user), params:) }

    let(:params) { {} }

    include_context('with authorization', 'superadmin')

    it { get_index and expect(response).to render_template :index }
  end
end
