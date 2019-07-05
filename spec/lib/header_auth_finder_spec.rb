# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::HeaderAuthFinder do
  describe '#authorization' do
    context 'with token' do
      let(:token) { 'token' }

      subject { described_class.new('Authorization' => "Bearer #{token}") }

      it 'returns token' do
        expect(subject.authorization).to eq token
      end
    end

    context 'without token' do
      subject { described_class.new({}) }

      it 'raises error' do
        expect { subject.authorization }.to raise_error(ApiAuthentication::Errors::Token::Missing,
                                                        I18n.t('api_authentication.errors.token.missing'))
      end
    end
  end
end
