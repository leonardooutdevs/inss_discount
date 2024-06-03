require 'rails_helper'

RSpec.describe FlashMessageHelper do
  describe '#flash_messages' do
    let(:flash) { {} }

    before do
      allow(helper).to receive(:flash).and_return(flash)
    end

    context 'when there are no flash messages' do
      it 'returns an empty string' do
        expect(helper.flash_messages).to eq('')
      end
    end

    context 'when there are flash messages' do
      let(:flash) { { notice: 'This is a notice', alert: 'This is an alert' } }

      it 'returns the correct HTML for notice', :aggregate_failures do
        expect(helper.flash_messages).to include('alert alert-success alert-dismissible fade show')
        expect(helper.flash_messages).to include('This is a notice')
      end

      it 'returns the correct HTML for alert', :aggregate_failures do
        expect(helper.flash_messages).to include('alert alert-danger alert-dismissible fade show')
        expect(helper.flash_messages).to include('This is an alert')
      end

      it 'includes a close button', :aggregate_failures do
        expect(helper.flash_messages).to include('class="btn-close"')
        expect(helper.flash_messages).to include('data-bs-dismiss="alert"')
        expect(helper.flash_messages).to include('aria-label="Close"')
      end
    end

    context 'when using different flash keys' do
      let(:flash) { { info: 'Information message', warn: 'Warning message' } }

      it 'returns the correct HTML for info', :aggregate_failures do
        expect(helper.flash_messages).to include('alert alert-primary alert-dismissible fade show')
        expect(helper.flash_messages).to include('Information message')
      end

      it 'returns the correct HTML for warn', :aggregate_failures do
        expect(helper.flash_messages).to include('alert alert-warning alert-dismissible fade show')
        expect(helper.flash_messages).to include('Warning message')
      end
    end
  end
end
