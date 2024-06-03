require 'rails_helper'

RSpec.describe Country do
  describe '#associations' do
    it { is_expected.to have_many(:states) }
  end

  describe '#validations' do
    subject(:country) { create(:country) }

    it { is_expected.to validate_presence_of(:name) }
  end
end
