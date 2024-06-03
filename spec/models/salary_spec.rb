require 'rails_helper'

RSpec.describe Salary do
  describe '#associations' do
    it { is_expected.to have_many(:proponents).dependent(:nullify) }
  end

  describe '#validations' do
    subject(:salary) { create(:salary) }

    it { is_expected.to validate_presence_of(:salary_range) }
    it { is_expected.to validate_presence_of(:max_amount) }
    it { is_expected.to validate_presence_of(:min_amount) }
    it { is_expected.to validate_presence_of(:calculation_basis) }
    it { is_expected.to validate_presence_of(:status) }
    it { expect(salary).to validate_uniqueness_of(:salary_range).scoped_to(:calculation_basis) }
  end
end
