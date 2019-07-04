# frozen_string_literal: true

module ApiAuthentication
  class Configuration
    include ActiveSupport::Configurable

    #
    # => Controller that should be inherited by engine ApplicationController, default is 'ActionController::Base'
    #
    config_accessor(:controller_to_inherit_from) { 'ActionController::Base' }

    #
    # => Enable Registrations endpoint
    #
    config_accessor(:registrations) { true }

    #
    # => Enable Push Tokens endpoint
    #
    config_accessor(:push_tokens) { true }

    #
    # => Enable Sessions endpoint
    #
    config_accessor(:sessions) { true }

    #
    # => add login from social_networks
    #
    config_accessor(:facebook_login) { true }

    #
    # => allow to set up in-app class name of users models
    #
    config_accessor(:auth_models) do
      [
        {
          model: 'User',
          validation_fields: %i[email password first_name last_name username birthday],
          registration_fields: %i[email password],
          login_field: :email,
          push_tokens: true,
          refresh_tokens: true,
          social_login: true,
          facebook_registration_fields: %i[email password first_name last_name username birthday]
        }
      ]
    end

    #
    # => allow to set up in-app class name of refresh token model
    #
    config_accessor(:app_refresh_token_model_class_name) { 'RefreshToken' }

    #
    # => allow to set up in-app class name of push token model
    #
    config_accessor(:app_push_token_model_class_name) { 'PushToken' }

    #
    # => secret_key
    #
    config_accessor(:secret_key) { '<%= SecureRandom.hex(64) %>' }

    #
    # => JWT token expiration
    #
    config_accessor(:jwt_token_exp) { 1.hour }

    config_accessor(:refresh_tokens) { true }

    config_accessor(:refresh_token_exp) { 1.month }
  end
end
