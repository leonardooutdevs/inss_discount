require 'rails_helper'

RSpec.describe 'Users::UserAccesses' do
  before { sign_in(user) }

  let(:user) { create(:user) }

  describe 'POST /create' do
    subject(:post_create) { post(user_user_accesses_path(user), params:) }

    let(:params) { { access_permission_level_id: access_permission_level.id } }

    context 'when successful create' do
      let(:access_permission) { create(:access_permission) }
      let(:access_level) { create(:access_level, name: 'level', kind: 'level') }

      let(:access_permission_level) do
        create(
          :access_permission_level,
          access_permission:,
          access_level:
        )
      end

      it_behaves_like 'a request'
      it { expect { post_create }.to change(UserAccess, :count).by(1) }
    end

    context 'when association already exist' do
      let(:access_permission_level) { create(:access_permission_level) }

      it { expect { post_create }.to raise_error(ActiveRecord::RecordNotUnique) }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch(user_user_access_path(user, user_access), params:) }

    let(:user_access) { user.user_accesses.sample }
    let(:access_permission_level) { user_access.access_permission_level }

    let(:params) do
      {
        access_permission_level_id: access_permission_level.id,
        access_level_id:
      }
    end

    context 'when successful create' do
      let(:access_level_id) do
        access_permission_level
          .access_permission
          .access_levels
          .find_by(kind: 'write').id
      end

      it_behaves_like 'a request'

      it do
        expect { patch_update and user_access.reload }
          .to change(user_access, :access_permission_level_id)
      end
    end
  end
end
