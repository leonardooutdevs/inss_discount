require 'rails_helper'

RSpec.describe 'Proponents::Reports' do
  before do
    sign_in(create(:user))
  end

  describe 'GET /index' do
    subject(:get_index) { get(reports_proponents_path) }

    context 'when successful' do
      it_behaves_like 'a request'

      it { expect { get_index }.to have_enqueued_job(Proponents::ReportsJob).at_least(1) }
    end
  end
end
