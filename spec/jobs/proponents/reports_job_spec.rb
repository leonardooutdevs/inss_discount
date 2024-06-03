require 'rails_helper'

RSpec.describe Proponents::ReportsJob do
  describe '#perform' do
    subject(:perform) { described_class.new.perform }

    before do
      create(:salary, :all)
      create(:proponent)
      allow(Turbo::StreamsChannel).to receive(:broadcast_update_to).and_call_original
    end

    it { expect { perform }.not_to raise_error }

    it 'calls broadcast_update_to twice' do
      perform

      expect(Turbo::StreamsChannel).to have_received(:broadcast_update_to).twice
    end
  end
end
