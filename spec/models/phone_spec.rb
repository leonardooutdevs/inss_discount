require 'rails_helper'

RSpec.describe Phone do
  describe '#validations' do
    subject(:phone) { create(:phone) }

    it { is_expected.to validate_presence_of(:number) }
  end
end
