shared_examples 'a request' do |kind|
  it { subject and expect(response).to have_http_status kind.presence || :success }
  it { expect { subject }.not_to raise_exception }
end

shared_examples 'a unauthorized request' do
  it 'is expected redirect to root and show alert', :aggregate_failures do
    expect(subject).to redirect_to(root_path)
    expect(flash[:alert])
      .to eql(I18n.t('user_not_authorized'))
  end
end

shared_context 'with authorization', shared_context: :metadata do |action_name|
  context 'when superadmin' do
    let(:user) { create(:user) }

    it_behaves_like 'a request'
  end

  context 'when admin' do
    let(:user) { create(:user, access_level_kind: 'admin') }

    it_behaves_like 'a request'
  end

  context 'when write' do
    let(:user) { create(:user, access_level_kind: 'write') }

    kind = action_name == 'destroy' ? :found : :ok

    it_behaves_like 'a request', kind
  end

  context 'when read' do
    let(:user) { create(:user, access_level_kind: 'read') }

    kind = %w[index show].include?(action_name) ? :ok : :found

    it_behaves_like 'a request', kind
    it_behaves_like('a unauthorized request') if kind == :found
  end

  context 'when default' do
    let(:user) { create(:user, access_level_kind: 'default') }

    it_behaves_like 'a request', :found
    it_behaves_like 'a unauthorized request'
  end
end
