# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::RefreshAccessToken do
  let(:refresh_token) { create(:refresh_token) }
  let(:request) { double(:request, headers: {}) }
  let(:tokens) { {} }

  subject { described_class.new(request) }

  describe '#call' do
    it 'creates new tokens and revokes refresh token' do
      expect(ApiAuthentication::RefreshAuthorizer).to(
        receive_message_chain(:new, :auth)
          .with(request.headers)
          .with(no_args)
          .and_return(refresh_token),
      )
      expect(ApiAuthentication::UserAuthenticator).to(
        receive_message_chain(:new, :auth)
          .with(user: refresh_token.user, request: request)
          .with(no_args)
          .and_return(tokens),
      )

      subject.call

      expect(refresh_token.revoked?).to be_truthy
      expect(subject.tokens).to eq tokens
    end
  end
end
