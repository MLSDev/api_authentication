# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::Configuration do
  its(:controller_to_inherit_from) { should eq 'ActionController::Base' }

  its(:registrations) { should eq true }
  its(:push_tokens) { should eq true }
  its(:sessions) { should eq true }
  its(:facebook_login) { should eq true }

  its(:auth_models) do
    [
      {
        model: 'User',
        registration_fields: %i[email password],
        login_field: :email,
        push_tokens: true,
        refresh_tokens: true,
        social_login: true,
        facebook_registration_fields: %i[email password first_name last_name username birthday]
      }
    ]
  end

  its(:app_refresh_token_model_class_name) { should eq 'RefreshToken' }
  its(:app_push_token_model_class_name) { should eq 'PushToken' }

  its(:secret_key) { should eq '<%= SecureRandom.hex(64) %>' }

  its(:jwt_token_exp) { should eq 1.hour }

  its(:refresh_tokens) { should eq true }

  its(:refresh_token_exp) { should eq 1.month }
end
