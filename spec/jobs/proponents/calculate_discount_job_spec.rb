require 'rails_helper'

RSpec.describe Proponents::CalculateDiscountJob do
  describe '#perform' do
    subject(:perform) { described_class.new.perform(gross_salary, current_user) }

    let(:current_user) { create(:user) }
    let(:gross_salary) { 3_000 }
    let(:discount) { 281.63 }

    before do
      create(:salary, :all)
      allow(Proponent::Discount).to receive(:call).and_call_original
      allow(Turbo::StreamsChannel).to receive(:broadcast_update_to).and_call_original
    end

    it { expect { perform }.not_to raise_error }
    it { perform and expect(Proponent::Discount).to have_received(:call) }

    it 'calls update_net_salary with correct parameters' do
      perform

      expect(Turbo::StreamsChannel).to have_received(:broadcast_update_to)
        .with("proponents_form_for_#{current_user.id}",
              target: "net_salary_for_#{current_user.id}",
              content: m(gross_salary - discount)).once
    end

    it 'calls update_discount with correct parameters' do
      perform

      expect(Turbo::StreamsChannel).to have_received(:broadcast_update_to)
        .with("proponents_form_for_#{current_user.id}",
              target: "discount_for_#{current_user.id}",
              content: m(discount)).once
    end
  end
end
