require 'rails_helper'

RSpec.describe ProponentAddress do
  describe '#associations' do
    it { is_expected.to belong_to(:proponent) }
    it { is_expected.to belong_to(:address) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:kind) }
  end
end
