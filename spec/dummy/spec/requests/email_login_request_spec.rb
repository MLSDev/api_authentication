require 'rails_helper'

describe 'LOGIN VIA EMAIL' do
  let(:headers) do
    {
      'ACCEPT'            => 'application/json',
      'HTTP_CONTENT_TYPE' => 'application/json'
    }
  end

  before { ENV['JWT_HMAC_SECRET'] = "some" }

  let(:password) { Faker::Internet.password }

  let!(:user) { ApiAuthentication::User.create! email: Faker::Internet.email, password: password }

  let(:path) { '/api/session' }

  context 'not valid email and password' do
    let(:params) do
      {
        "session": {
          "email":                 user.email,
          "password":              password
        }
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response).to have_http_status :success
    end
  end

  context 'not valid email' do
    let(:email) { Faker::Internet.email }

    let(:params) do
      {
        "session": {
          "email":    email,
          "password": password
        }
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response.content_type).to eq 'application/json'

      expect(response).to have_http_status :unprocessable_entity
    end
  end

  context 'not valid password' do
    let(:params) do
      {
        "session": {
          "email":    user.email,
          "password": 'password'
        }
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response.content_type).to eq 'application/json'

      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
