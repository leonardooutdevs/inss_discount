require 'rails_helper'

RSpec.describe 'Proponents::CalculateDiscounts' do
  before do
    sign_in(current_user)
    allow(Proponents::CalculateDiscountJob).to receive(:perform_later).and_call_original
  end

  let(:current_user) { create(:user) }

  describe 'GET /index' do
    subject(:get_index) { get(calculate_discount_proponents_path, params:) }

    let(:params) { { gross_salary:, format: :turbo_stream } }
    let(:gross_salary) { '3000' }

    context 'when successful' do
      it_behaves_like 'a request'

      it do
        get_index
        expect(Proponents::CalculateDiscountJob)
          .to have_received(:perform_later)
          .with(gross_salary, current_user)
      end

      it { expect { get_index }.to have_enqueued_job(Proponents::CalculateDiscountJob).at_least(1) }
    end
  end
end
