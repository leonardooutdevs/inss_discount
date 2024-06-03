require 'rails_helper'

RSpec.describe State do
  describe '#associations' do
    it { is_expected.to belong_to(:country) }
    it { is_expected.to have_many(:cities).dependent(:destroy) }
  end

  describe '#validations' do
    subject(:state) { create(:state) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:uf) }
    it { is_expected.to validate_presence_of(:ibge_code) }
    it { expect(state).to validate_uniqueness_of(:name).scoped_to(:country_id) }
  end
end
