require 'rails_helper'

RSpec.describe UserAccess do
  describe '#associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:access_permission_level).class_name('AccessPermissionLevel') }

    it { is_expected.to have_one(:access_permission).through(:access_permission_level) }
  end
end
