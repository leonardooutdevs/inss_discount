require 'rails_helper'

RSpec.describe Address do
  describe '#associations' do
    it { is_expected.to belong_to(:city) }
    it { is_expected.to have_one(:state).through(:city) }
    it { is_expected.to have_one(:country).through(:city) }
  end

  describe '#validations' do
    subject(:address) { create(:address) }

    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_presence_of(:zip_code) }

    it do
      expect(address).to validate_uniqueness_of(:address)
        .scoped_to(:city_id, :number, :complement, :neighborhood, :zip_code)
    end
  end
end
