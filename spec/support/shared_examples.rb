KINDS = {
  'default' => 0,
  'read' => 1,
  'write' => 2,
  'admin' => 3,
  'superadmin' => 4
}.freeze

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

shared_context 'with authorization', shared_context: :metadata do |data|
  permission_level_necessary, status_code = *data

  %w[superadmin admin write read default].each do |access_level_kind|
    context "when #{access_level_kind}" do
      let(:user) { create(:user, access_level_kind:) }

      status = KINDS[access_level_kind] >= KINDS[permission_level_necessary] ? (status_code.presence || :ok) : 303

      it_behaves_like('a request', status)
      it_behaves_like('a unauthorized request') if status == 303
    end
  end
end
