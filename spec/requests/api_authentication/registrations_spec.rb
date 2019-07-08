# frozen_string_literal: true

require 'rails_helper'

describe 'Registrations', type: :request do
  before(:each) { @routes = ApiAuthentication::Engine.routes }

  let(:params) do
    {
      user: {
        email: FFaker::Internet.email,
        password: FFaker::Internet.password,
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name,
        username: FFaker::Internet.user_name,
        birthday: Date.current - 18.years
      }
    }
  end

  let(:schema) do
    {
      id: be_kind_of(Integer),
      email: be_kind_of(String),
      username: be_kind_of(String),
      first_name: be_kind_of(String),
      last_name: be_kind_of(String),
      birthday: be_kind_of(String)
    }
  end

  describe '/registrations' do
    it 'creates new user' do
      post registrations_path(format: :json), params: params

      expect(json_response).to match(schema)
    end
  end
end
