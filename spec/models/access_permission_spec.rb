require 'rails_helper'

RSpec.describe AccessPermission do
  describe '#associations' do
    it { is_expected.to have_many(:access_permission_levels).dependent(:destroy) }
    it { is_expected.to have_many(:access_levels).through(:access_permission_levels) }
  end

  describe '#validations' do
    subject(:access_permission) { create(:access_permission) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:model) }
    it { expect(access_permission).to validate_uniqueness_of(:model) }
  end
end
