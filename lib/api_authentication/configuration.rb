# frozen_string_literal: true

module ApiAuthentication
  class Configuration
    include ActiveSupport::Configurable

    #
    # => Controller that should be inherited by engine ApplicationController, default is 'ActionController::Base'
    #
    config_accessor(:controller_to_inherit_from) { 'ActionController::Base' }

    #
    # => fields for registration
    #
    config_accessor(:registration_fields) { %i[email password first_name last_name username birthday] }

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
    # => allow to set up in-app class name of user model
    #
    config_accessor(:app_user_model_class_name) { 'User' }

    #
    # => allow to set up in-app class name of refresh token model
    #
    config_accessor(:app_refresh_token_model_class_name) { 'RefreshToken' }

    #
    # => allow to set up in-app class name of push token model
    #
    config_accessor(:app_push_token_model_class_name) { 'PushToken' }

    #
    # => User model fields
    #
    config_accessor(:user_fields) { %i[email password first_name last_name username birthday] }

    #
    # => secret_key
    #
    config_accessor(:secret_key) { '<%= SecureRandom.hex(64) %>' }

    #
    # => JWT token expiration
    #
    config_accessor(:jwt_token_exp) { 1.hour }
    config_accessor(:refresh_token_exp) { 1.month }
  end
end
