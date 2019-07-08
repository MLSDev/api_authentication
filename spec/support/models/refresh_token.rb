# frozen_string_literal: true

shared_examples 'api_auth_refresh_token' do
  context 'relations' do
    it do
      should belong_to(:user).class_name(ApiAuthentication.configuration.auth_models.first.fetch(:model))
    end
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

  describe '#expired?' do
    it 'true' do
      subject.expired_at = DateTime.current

      expect(subject.expired?).to be_truthy
    end

    it 'false' do
      subject.expired_at = DateTime.current + 1.minute

      expect(subject.expired?).to be_falsey
    end
  end

  describe '#revoked?' do
    it 'true' do
      subject.revoked_at = DateTime.current

      expect(subject.revoked?).to be_truthy
    end

    it 'false' do
      subject.revoked_at = nil

      expect(subject.revoked?).to be_falsey
    end
  end

  describe '#revoke!' do
    it do
      subject.revoke!
      expect(subject.revoked_at).to_not be_nil
    end
  end
end
