# frozen_string_literal: true

require 'rails_helper'

describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  before(:each) { @routes = ApiAuthentication::Engine.routes }

  describe '/sessions' do
    it 'creates new session' do
      headers = {
        'User-Agent': 'test'
      }
      post sessions_path(format: :json),
           params: {
             session: {
               email: user.email,
               password: user.password
             }
           },
           headers: headers

      expect(json_response).to match(access_token: be_a_kind_of(String), refresh_token: be_a_kind_of(String))
    end

    it 'deletes refresh token' do
      refresh_token = create(:refresh_token, user: user)
      headers = {
        'Authorization': "Bearer #{refresh_token.token}"
      }

      delete sessions_path(format: :json), params: {}, headers: headers

      expect(response).to have_http_status(:no_content)
    end
  end
end
