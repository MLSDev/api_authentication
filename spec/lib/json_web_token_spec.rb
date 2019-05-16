# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::JsonWebToken do
  context 'constants' do
    it { expect(described_class::HMAC_SECRET).to eq ApiAuthentication.configuration.secret_key }
  end

  describe '.encode' do
    let(:initial_payload) { {} }
    let(:exp_time) { 1111 }
    let(:changed_payload) { { exp: exp_time } }

    it do
      expect(ApiAuthentication).to(
        receive_message_chain(:configuration, :jwt_token_exp, :from_now, :to_i)
          .and_return(exp_time),
      )
      expect(JWT).to receive(:encode).with(changed_payload, described_class::HMAC_SECRET)

      described_class.encode(initial_payload)
    end
  end

  describe '.decode' do
    let(:token) { 'token' }
    let(:decoded_body) { {} }

    it 'returns decoded body' do
      expect(JWT).to receive(:decode).with(token, described_class::HMAC_SECRET).and_return([decoded_body])

      result = described_class.decode(token)

      expect(result).to eq decoded_body
      expect(result.class).to eq ActiveSupport::HashWithIndifferentAccess
    end

    it 'raises error' do
      expect { described_class.decode('token') }.to raise_error(ApiAuthentication::Token::Invalid)
    end
  end
end