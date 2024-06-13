require 'rails_helper'

RSpec.describe 'AccessLevels' do
  before { sign_in(user) }

  let(:user) { create(:user) }

  describe 'GET /index' do
    subject(:get_index) { get('/access_levels', params:) }

    let(:params) { {} }

    include_context 'with authorization', 'superadmin'
    it { get_index and expect(response).to render_template :index }
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get access_level_path(access_level) }

      let(:access_level) { create(:access_level) }

      include_context 'with authorization', 'superadmin'
      it { get_show and expect(response).to render_template :_access_level }
    end
  end

  describe 'GET /new' do
    context 'when successful' do
      subject(:get_new) { get new_access_level_path }

      include_context 'with authorization', 'superadmin'
      it { get_new and expect(response).to render_template :_form }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_access_level_path(access_level) }

      let(:access_level) { create(:access_level) }

      include_context 'with authorization', 'superadmin'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'POST /create' do
    subject(:post_create) { post access_levels_path, params: }

    let(:params) { { access_level: access_level_attributes, format: :turbo_stream } }
    let(:access_level_attributes) { { name: 'name', kind: 'kind' } }

    include_context 'with authorization', 'superadmin'

    it { expect { post_create }.to change(AccessLevel, :count).by(1) }

    context 'when validation fails' do
      let(:access_level_attributes) { { name: nil } }

      it_behaves_like 'a request'
      it { expect { post_create }.not_to change(AccessLevel, :count) }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch access_level_path(access_level), params: }

    let(:access_level) { create(:access_level) }
    let(:params) { { access_level: { name: 'Canada' }, format: :turbo_stream } }

    include_context 'with authorization', 'superadmin'
    it { expect { patch_update and access_level.reload }.to change(access_level, :attributes) }

    context 'when validation fails' do
      let(:params) { { access_level: { name: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and access_level.reload }.not_to change(access_level, :attributes) }
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_destroy) { delete(access_level_path(access_level)) }

    let(:access_level) { create(:access_level) }

    include_context 'with authorization', 'superadmin'
    it { access_level and expect { delete_destroy }.to change(AccessLevel, :count) }

    it do
      access_level
      expect { delete_destroy }
        .to change(access_level.access_permission_levels, :count)
    end
  end
end
