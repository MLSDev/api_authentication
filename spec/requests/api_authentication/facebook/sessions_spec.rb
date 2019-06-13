# frozen_string_literal: true

require 'rails_helper'

describe 'FacebookSession', type: :request do
  let(:access_token) do
    'EAATNbOL45KkBAAGKdGYTjgjyJ3y75jKAZAhAZCBhgL659bYsNHAabSc4HCyQe'\
    'AXZAF5uWgfOtylAuYAIvZCgj7ZAxDwhFAqZCSroCZChxDjosM3S1kqu2Lg8FAqGblWXb5bGI9'\
    'JvhpjfgywVDnFblIu9M2U3d5ZCYiioE6VLszIfLkIQHHU3nszQliqj8nDE7v8ds3nrLGzmWQZDZD'
  end
  let(:params) do
    {
      session: {
        access_token: access_token
      }
    }
  end
  let(:user_agent) do
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
        'Chrome/60.0.3112.113 Safari/537.36'
  end

  before do
    @routes = ApiAuthentication::Engine.routes
    VCR.insert_cassette 'facebook/me_success'
    allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(FFaker::Internet.ip_v4_address)
    allow_any_instance_of(ActionDispatch::Request).to receive(:user_agent).and_return(user_agent)
  end

  describe '/facebook/sessions' do
    it 'creates new tokens' do
      post facebook_sessions_path(format: :json), params: params

      expect(json_response).to match(access_token: be_a_kind_of(String), refresh_token: be_a_kind_of(String))
    end
  end

  after { VCR.eject_cassette }
end
