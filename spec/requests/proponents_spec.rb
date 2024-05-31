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

  describe 'POST /create' do
    subject(:post_create) { post proponents_path, params: }

    let(:params) { { proponent: proponent_attributes, format: :turbo_stream } }

    let(:proponent_attributes) do
      attributes_for(
        :proponent,
        gross_salary:,
        address_id: create(:address).id,
        phone_id: create(:phone).id
      )
    end

    before { create(:salary, :all) }

    shared_examples 'successful creation with discount' do
      it_behaves_like 'a request'

      it { expect { post_create }.to change(Proponent, :count).by(1) }

      it 'is expected calculate correctly discount', :aggregate_failures do
        post_create
        proponent = Proponent.order(:created_at).last
        expect(proponent.gross_salary).to eq(gross_salary)
        expect(proponent.discount).to be_within(0.01).of(discount)
        expect(proponent.net_salary).to be_within(0.01).of(gross_salary - discount)
      end
    end

    context 'when gross_salary = 3000' do
      let(:gross_salary) { 3_000 }
      let(:discount) { 281.62 }

      it_behaves_like 'successful creation with discount'
    end

    context 'when gross_salary = 6000' do
      let(:gross_salary) { 6_000 }
      let(:discount) { 698.95 }

      it_behaves_like 'successful creation with discount'
    end

    context 'when validation fails' do
      let(:proponent_attributes) { attributes_for(:proponent, name: '') }

      it_behaves_like 'a request'
      it { expect { post_create }.not_to change(Proponent, :count) }
    end
  end
end
