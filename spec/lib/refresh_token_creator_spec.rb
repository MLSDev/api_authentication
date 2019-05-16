# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::RefreshTokenCreator do
  describe '.create' do
    let(:user) { create(:user) }

    context 'create token' do
      let(:token) { 'token' }
      let(:exp_time) { Time.current }
      let(:user_agent) do
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
        'Chrome/60.0.3112.113 Safari/537.36'
      end
      let(:request) { double(:request, remote_ip: FFaker::Internet.ip_v4_address, user_agent: user_agent) }

      subject { described_class.new(user: user, request: request) }

      it do
        expect(ApiAuthentication.refresh_token_model).to receive(:generate_token).and_return(token)
        expect(ApiAuthentication.configuration).to receive_message_chain(:refresh_token_exp, :from_now)
          .and_return(exp_time)

        refresh_token = subject.create

        expect(refresh_token.persisted?).to eq true
        expect(refresh_token.user_id).to eq user.id
        expect(refresh_token.token).to eq token
        expect(refresh_token.expired_at).to eq exp_time
        expect(refresh_token.ip_address).to eq request.remote_ip
        expect(refresh_token.user_agent).to eq request.user_agent
      end
    end

    context 'not create token' do
      subject { described_class.new(user: user, request: {}) }

      it do
        expect(ApiAuthentication.configuration).to receive(:app_refresh_token_model_class_name)

        expect(subject.create).to be nil
      end
    end
  end
end
