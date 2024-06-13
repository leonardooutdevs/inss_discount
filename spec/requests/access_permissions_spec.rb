require 'rails_helper'

RSpec.describe 'AccessPermissions' do
  before { sign_in(user) }

  let(:user) { create(:user) }

  describe 'GET /index' do
    subject(:get_index) { get('/access_permissions', params:) }

    let(:params) { {} }

    include_context 'with authorization', 'superadmin'
    it { get_index and expect(response).to render_template :index }
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get access_permission_path(access_permission) }

      let(:access_permission) { create(:access_permission) }

    include_context 'with authorization', 'superadmin'
      it { get_show and expect(response).to render_template :_access_permission }
    end
  end

  describe 'GET /new' do
    context 'when successful' do
      subject(:get_new) { get new_access_permission_path }

    include_context 'with authorization', 'superadmin'
      it { get_new and expect(response).to render_template :_form }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_access_permission_path(access_permission) }

      let(:access_permission) do
        create(:access_permission)
      end

    include_context 'with authorization', 'superadmin'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'POST /create' do
    subject(:post_create) { post access_permissions_path, params: }

    let(:params) { { access_permission: access_permission_attributes, format: :turbo_stream } }
    let(:access_permission_attributes) { { name: 'ProponentAddress', model: 'ProponentAddress' } }

    before { AccessPermission.find_by(name: 'ProponentAddress').destroy }

    include_context 'with authorization', 'superadmin'
    it { expect { post_create }.to change(AccessPermission, :count).by(1) }

    context 'when validation fails' do
      let(:access_permission_attributes) { { name: nil } }

      it_behaves_like 'a request'
      it { expect { post_create }.not_to change(AccessPermission, :count) }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch access_permission_path(access_permission), params: }

    let(:access_permission) { create(:access_permission) }
    let(:params) { { access_permission: { name: 'Canada' }, format: :turbo_stream } }

    include_context 'with authorization', 'superadmin'
    it { expect { patch_update and access_permission.reload }.to change(access_permission, :attributes) }

    context 'when validation fails' do
      let(:params) { { access_permission: { name: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and access_permission.reload }.not_to change(access_permission, :attributes) }
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_destroy) { delete(access_permission_path(access_permission)) }

    let(:access_permission) { create(:access_permission) }

    include_context 'with authorization', 'superadmin'
    it { access_permission and expect { delete_destroy }.to change(AccessPermission, :count) }

    it do
      access_permission
      expect { delete_destroy }
        .to change(access_permission.access_permission_levels, :count)
    end
  end
end
