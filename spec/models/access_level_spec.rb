require 'rails_helper'

RSpec.describe AccessLevel do
  describe '#associations' do
    it { is_expected.to have_many(:access_permission_levels).dependent(:destroy) }
  end

  describe '#validations' do
    subject(:access_level) { create(:access_level) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:kind) }
    it { expect(access_level).to validate_uniqueness_of(:kind) }
  end
end
