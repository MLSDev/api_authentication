# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::UserAuthenticator do
  let(:user) { create(:user) }
  let(:request) { {} }

  subject { described_class.new(email: user.email, password: user.password, request: request) }

  describe '#auth' do
    let(:access_token_payload) { { user_id: user.id } }
    let(:access_token) { 'access_token' }
    let(:refresh_token) { double(:refresh_token, token: 'refresh_token') }
    let(:refresh_token_creator) { double(:refresh_token_creator, create: refresh_token) }

    before do
      expect(ApiAuthentication::JsonWebToken).to receive(:encode).with(access_token_payload).and_return(access_token)
    end

    it 'returns access and refresh tokens' do
      expect(ApiAuthentication::RefreshTokenCreator).to receive(:new)
        .with(user: user, request: request)
        .and_return(refresh_token_creator)

      expect(subject.auth).to eq(access_token: access_token, refresh_token: refresh_token.token)
    end

    it 'returns only access token' do
      expect(ApiAuthentication.configuration).to receive(:app_refresh_token_model_class_name)

      expect(subject.auth).to eq(access_token: access_token)
    end
  end

  describe '#user' do
    it 'authenticates user' do
      expect(subject.user).to eq user
    end

    context 'returns user from params' do
      subject { described_class.new(user: user, request: request) }

      it do
        expect(subject.user).to eq user
      end
    end

    context 'raise error' do
      subject { described_class.new(email: user.email, password: user.password.reverse, request: request) }

      it do
        expect { subject.user }.to raise_error(ApiAuthentication::Auth::InvalidCredentials,
                                               I18n.t('api_authentication.errors.auth.invalid_credentials'))
      end
    end
  end
end
