require 'rails_helper'

RSpec.describe City do
  describe '#associations' do
    it { is_expected.to belong_to(:state).class_name('State') }
    it { is_expected.to have_many(:addresses) }
  end

  describe '#validations' do
    subject(:city) { create(:city) }

    it { is_expected.to validate_presence_of(:ibge_code) }
    it { is_expected.to validate_presence_of(:name) }
    it { expect(city).to validate_uniqueness_of(:name).scoped_to(:state_id) }
  end
end
