require 'rails_helper'

RSpec.describe ProponentPhone do
  describe '#associations' do
    it { is_expected.to belong_to(:proponent) }
    it { is_expected.to belong_to(:phone) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
