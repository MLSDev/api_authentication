# frozen_string_literal: true

shared_examples 'api_auth_refresh_token' do
  context 'relations' do
    it { should belong_to(ApiAuthentication.configuration.app_user_model_class_name.downcase.to_sym) }
  end

  context 'validations' do
    it { should validate_presence_of(:expired_at) }
    it { should validate_presence_of(:ip_address) }
    it { should validate_presence_of(:user_agent) }
  end

  describe '.generate_token' do
    let(:token) { 'token' }

    it do
      expect(SecureRandom).to receive(:base58).with(100).and_return(token)

      expect(described_class.generate_token).to eq token
    end
  end
end