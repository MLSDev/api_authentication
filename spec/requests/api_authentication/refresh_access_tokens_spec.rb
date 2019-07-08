# frozen_string_literal: true

require 'rails_helper'

describe 'RefreshAccessTokens', type: :request do
  let!(:user) { create(:user) }

  before(:each) { @routes = ApiAuthentication::Engine.routes }

  describe '/access_tokens' do
    it 'creates new tokens' do
      refresh_token = create(:refresh_token, user: user)
      headers = {
        'Authorization': "Bearer #{refresh_token.token}",
        'User-Agent': 'test'
      }

      post access_tokens_path(format: :json), params: {}, headers: headers

      expect(json_response).to match(access_token: be_a_kind_of(String), refresh_token: be_a_kind_of(String))
    end
  end
end
