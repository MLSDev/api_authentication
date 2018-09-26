require 'rails_helper'

describe 'FACEBOOK LOGIN' do
  let(:headers) do
    {
      'ACCEPT'            => 'application/json',
      'HTTP_CONTENT_TYPE' => 'application/json'
    }
  end

  before { ENV['JWT_HMAC_SECRET'] = "some" }

  let(:password) { Faker::Internet.password }

  let!(:user) { ApiAuthentication::User.create! email: Faker::Internet.email, password: password }

  let(:path) { '/api/facebook/session' }

  ### TO DO => add vcr for mock response

  context 'valid access_token' do
    let(:params) do
      {
        "access_token": "EAACEdEose0cBAMyvSWCoaC4o0tBGhk9MWVodt0xgAqayHT9AveYsszNxHja72ZAjZApGcvBbFC6tlT8vjRan4uq2mfcDZCpoWTIBaDYbfXV8kGkQk8T73gvkLA0cmUf541N5BiJZBIOGniQl1HUiZBZCKCMQDBWbZAYPvRrHEYwqrlCGfV6ZAqwDZAZCBVInpkdawZD"
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response).to have_http_status :success
    end
  end
end
