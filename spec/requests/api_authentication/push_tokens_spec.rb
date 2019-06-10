# frozen_string_literal: true

require 'rails_helper'

describe 'PushTokens', type: :request do
  let!(:user) { create(:user) }

  before { sign_in(user, ApiAuthentication::PushTokensController) }

  before(:each) { @routes = ApiAuthentication::Engine.routes }

  let(:params) do
    {
      push_token: {
        token: SecureRandom.hex(5),
        device_type: 'android'
      }
    }
  end

  let(:schema) do
    {
      id: be_kind_of(Integer),
      token: be_kind_of(String),
      device_type: be_kind_of(String)
    }
  end

  describe '/push_tokens' do
    it 'creates new push token' do
      post push_tokens_path(format: :json), params: params

      expect(json_response).to match(schema)
    end

    it 'deletes push token' do
      push_token = create(:push_token, user: user)
      delete push_tokens_path(format: :json), params: { token: push_token.token }

      expect(response).to have_http_status(:no_content)
    end
  end
end
