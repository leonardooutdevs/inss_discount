require 'rails_helper'

RSpec.describe User do
  describe '#validations' do
    subject(:user) { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
  end
end
