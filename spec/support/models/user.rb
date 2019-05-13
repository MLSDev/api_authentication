# frozen_string_literal: true

shared_examples 'api_auth_user' do
  it { expect(described_class::EMAIL_REGEX).to eq /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  context 'relations' do
    it { have_many(ApiAuthentication.configuration.app_refresh_token_model_class_name.underscore.to_sym) }
    it { have_many(ApiAuthentication.configuration.app_push_token_model_class_name.underscore.to_sym) }
  end

  context 'validations' do
    it { should allow_value(FFaker::Internet.email).for(:email) }
    it { should_not allow_value('wrong email').for(:email) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
  end
end