# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::RefreshAuthorizer do
  describe '#auth' do
    let(:headers) { {} }
    let(:header_auth_finder) { instance_double('HeaderAuthFinder', authorization: 'token') }

    subject { described_class.new(headers) }

    before do
      expect(ApiAuthentication::HeaderAuthFinder).to receive(:new).with(headers).and_return(header_auth_finder)
    end

    context 'find token' do
      let!(:refresh_token) { create(:refresh_token) }

      it 'returns token' do
        expect(header_auth_finder).to receive(:authorization).and_return(refresh_token.token)

        expect(subject.auth).to eq refresh_token
      end
    end

    context 'raises error' do
      it 'if token not found' do
        expect { subject.auth }.to raise_error(ApiAuthentication::Errors::Token::Invalid,
                                               I18n.t('api_authentication.errors.token.invalid'))
      end

      context 'for expired token' do
        let!(:refresh_token) { create(:refresh_token, expired_at: DateTime.current) }

        it do
          expect(header_auth_finder).to receive(:authorization).and_return(refresh_token.token)

          expect { subject.auth }.to raise_error(ApiAuthentication::Errors::Token::Invalid,
                                                 I18n.t('api_authentication.errors.token.invalid'))
        end
      end

      context 'for revoked token' do
        let!(:refresh_token) { create(:refresh_token, revoked_at: DateTime.current) }

        it do
          expect(header_auth_finder).to receive(:authorization).and_return(refresh_token.token)

          expect { subject.auth }.to raise_error(ApiAuthentication::Errors::Token::Invalid,
                                                 I18n.t('api_authentication.errors.token.invalid'))
        end
      end
    end
  end
end
