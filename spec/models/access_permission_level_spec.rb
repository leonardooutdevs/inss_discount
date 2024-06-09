require 'rails_helper'

RSpec.describe AccessPermissionLevel do
  describe '#associations' do
    it { is_expected.to belong_to(:access_permission).class_name('AccessPermission') }
    it { is_expected.to belong_to(:access_level).class_name('AccessLevel') }

    it { is_expected.to have_many(:user_accesses).dependent(:destroy) }
  end
end
