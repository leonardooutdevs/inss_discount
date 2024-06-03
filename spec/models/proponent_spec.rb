require 'rails_helper'

RSpec.describe Proponent do
  describe '#associations' do
    it { is_expected.to belong_to(:salary) }

    it { is_expected.to have_many(:proponent_addresses).dependent(:destroy) }
    it { is_expected.to have_many(:addresses).through(:proponent_addresses) }

    it { is_expected.to have_many(:proponent_phones).dependent(:destroy) }
    it { is_expected.to have_many(:phones).through(:proponent_phones) }
  end

  describe '#validations' do
    subject(:proponent) { create(:proponent) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:gross_salary) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_presence_of(:net_salary) }
    it { is_expected.to validate_presence_of(:document) }
    it { is_expected.to validate_presence_of(:birth_date) }
    it { expect(proponent).to validate_uniqueness_of(:document).case_insensitive }
    it { is_expected.to allow_value('123456789').for(:document) }
    it { is_expected.not_to allow_value('12345678a').for(:document) }
  end

  describe '#calculate_discount' do
    subject(:proponent) { build(:proponent) }

    before do
      create(:salary, :all)
      allow(described_class::Discount).to receive(:call).and_call_original
    end

    it { proponent.save and expect(described_class::Discount).to have_received(:call) }

    it do
      expect { proponent.save and proponent.reload }
        .to change(proponent, :discount)
        .and change(proponent, :net_salary)
        .and change(proponent, :salary_id)
    end
  end
end
