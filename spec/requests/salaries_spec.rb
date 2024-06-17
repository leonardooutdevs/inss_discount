require 'rails_helper'

RSpec.describe 'Salaries' do
  before { sign_in(create(:user)) }

  describe 'GET /index' do
    subject(:get_index) { get('/salaries', params:) }

    let(:params) { {} }

    context 'when successful' do
      it_behaves_like 'a request'
      it { get_index and expect(response).to render_template :index }
    end
  end

  describe 'GET /edit' do
    context 'when successful' do
      subject(:get_edit) { get edit_salary_path(salary, format: :turbo_stream) }

      let(:salary) { create(:salary) }

      it_behaves_like 'a request'
      it { get_edit and expect(response).to render_template :_form }
    end
  end

  describe 'GET /show' do
    context 'when successful' do
      subject(:get_show) { get salary_path(salary, format: :turbo_stream) }

      let(:salary) { create(:salary) }

      it_behaves_like 'a request'
      it { get_show and expect(response).to render_template :_salary }
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch salary_path(salary), params: }

    let(:salary) { create(:salary) }
    let(:params) { { salary: { salary_range: 'Canada' }, format: :turbo_stream } }

    it_behaves_like 'a request'
    it { expect { patch_update and salary.reload }.to change(salary, :attributes) }

    context 'when validation fails' do
      let(:params) { { salary: { salary_range: '' } } }

      it_behaves_like 'a request'
      it { expect { patch_update and salary.reload }.not_to change(salary, :salary_range) }
    end
  end

  describe 'delete /destroy' do
    subject(:delete_destroy) { delete salary_path(salary), params: }

    let(:salary) { create(:salary) }
    let(:params) { {} }

    it_behaves_like 'a request'
    it { salary and expect { delete_destroy }.to change(Salary, :count) }
  end
end
