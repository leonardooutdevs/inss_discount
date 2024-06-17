require 'rails_helper'

RSpec.describe 'AccessPermissions::AccessLevels' do
  before { sign_in(create(:user)) }

  describe 'POST /create' do
    subject(:post_create) do
      post(access_permission_access_levels_path(access_permission), params:)
    end

    let(:params) { { id: access_level.id } }
    let(:access_permission) { create(:access_permission) }
    let(:access_level) { create(:access_level, name: 'level', kind: 'level') }

    it_behaves_like 'a request'
    it { expect { post_create }.to change(AccessPermissionLevel, :count).by(1) }
  end

  describe 'delete /destroy' do
    subject(:delete_destroy) do
      delete(
        access_permission_access_level_path(
          access_permission_level.access_permission,
          access_permission_level.access_level
        )
      )
    end

    let(:access_permission_level) { create(:access_permission_level) }

    it_behaves_like 'a request'
    it { access_permission_level and expect { delete_destroy }.to change(AccessPermissionLevel, :count) }
  end
end
