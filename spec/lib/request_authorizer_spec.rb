# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::RequestAuthorizer do
  describe '#auth' do
    let(:headers) { {} }
    let(:header_auth_finder) { instance_double('HeaderAuthFinder', authorization: 'token') }

    subject { described_class.new(headers) }

    before do
      expect(ApiAuthentication::HeaderAuthFinder).to receive(:new).with(headers).and_return(header_auth_finder)
    end

    context 'authorize user' do
      let(:user) { create(:user) }
      let(:decoded_auth_token) { { user_id: user.id } }

      it do
        expect(ApiAuthentication::JsonWebToken).to receive(:decode)
          .with(header_auth_finder.authorization)
          .and_return(decoded_auth_token)

        expect(subject.auth).to eq user
      end
    end

    context 'raises error' do
      it do
        expect(ApiAuthentication::JsonWebToken).to receive(:decode)
          .with(header_auth_finder.authorization)
          .and_return(user_id: 1)

        expect { subject.auth }.to raise_error(ApiAuthentication::Token::Invalid,
                                               I18n.t('api_authentication.errors.token.invalid'))
      end
    end
  end
end
