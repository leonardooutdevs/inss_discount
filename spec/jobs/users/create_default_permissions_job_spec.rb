require 'rails_helper'

RSpec.describe Users::CreateDefaultPermissionsJob do
  describe '#perform' do
    subject(:perform) { described_class.new.perform(user.id) }

    let(:user) { create(:user, with_accesses: false) }

    it { expect { perform }.not_to raise_error }
    it { expect { perform }.to change(UserAccess, :count).by(14) }
  end
end
