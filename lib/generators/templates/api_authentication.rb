# frozen_string_literal: true

# These configuration options can be used to customise the behaviour of ApiAuthentication
ApiAuthentication.configure do |config|
  #
  # => Controller that should be inherited by engine ApplicationController, default is 'ActionController::Base'
  #
  # config.controller_to_inherit_from = 'ActionController::Base'

  #
  # => Enable Registrations endpoint
  #
  # config.registrations = true

  #
  # => Enable Push Tokens endpoint
  #
  # config.push_tokens = true

  #
  # => Enable Sessions endpoint
  #
  # config.sessions = true

  # => add login from social_networks
  #
  # config.facebook_login = true

  #
  # => allow to set up in-app class name of users models
  #
  # config.auth_models = [
  #   {
  #     model: 'User',
  #     validation_fields: %i[email password first_name last_name username birthday],
  #     registration_fields: %i[email password],
  #     login_field: :email,
  #     push_tokens: true,
  #     refresh_tokens: true,
  #     social_login: true,
  #     facebook_registration_fields: %i[email password first_name last_name username birthday]
  #   }
  # ]

  #
  # => allow to set up in-app class name of refresh token model
  #
  # config.app_refresh_token_model_class_name = 'RefreshToken'

  #
  # => allow to set up in-app class name of push token model
  #
  # config.app_push_token_model_class_name = 'PushToken'

  #
  # => secret_key
  #
  # config.secret_key = 'key'

  #
  # => JWT token expiration
  #
  # config.jwt_token_exp = 1.hour.from_now
  # config.refresh_tokens = true
  # config.refresh_token_exp = 1.month.from_now
end
