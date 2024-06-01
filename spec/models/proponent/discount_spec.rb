require 'rails_helper'

RSpec.describe Proponent::Discount do
  describe '#call' do
    subject(:call) { described_class.call(proponent) }

    let(:proponent) { Proponent.new(gross_salary:) }
    let(:net_salary) { (gross_salary - discount).round(2) }

    before { create(:salary, :all) }

    shared_examples 'successful calculation' do
      it { expect { call }.not_to raise_error }
      it { expect(call[0]).to be_within(0.01).of(discount) }
      it { expect(call[1]).to be_within(0.01).of(net_salary) }
    end

    context 'when up to R$ 1.045,00' do
      let(:gross_salary) { 1045.00 }
      let(:discount) { 78.38 }

      it_behaves_like 'successful calculation'
    end

    context 'when up to R$ 1.045,01 a R$ 2.089,60' do
      let(:gross_salary) { 2089.60 }
      let(:discount) { 172.39 }

      it_behaves_like 'successful calculation'
    end

    context 'when up to R$ 2.089,61 até R$ 3.134,40' do
      let(:gross_salary) { 3134.40 }
      let(:discount) { 297.76 }

      it { expect { call }.not_to raise_error }
      it { expect(call).to eq([discount, net_salary]) }
    end

    context 'when up to R$ 3.134,41 até R$ 6.101,06' do
      let(:gross_salary) { 5_000 }
      let(:discount) { 558.95 }

      it { expect { call }.not_to raise_error }
      it { expect(call).to eq([discount, net_salary]) }
    end
  end
end
