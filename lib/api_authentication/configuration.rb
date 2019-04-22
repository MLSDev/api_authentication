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
    config_accessor(:registration_fields) { %w[email first_name last_name username full_name birthday avatar] }

    #
    # => add login from social_networks
    #
    config_accessor(:facebook_login) { true }
    # config_accessor(:filled_by_facebook) { %w[first_name last_name username full_name birthday avatar] }

    #
    # => allow to set up in-app class name of user model
    #
    config_accessor(:app_user_model_class_name) { 'User' }

    #
    # => secret_key
    #
    config_accessor(:secret_key) { '<%= SecureRandom.hex(64) %>' }

    #
    # => JWT token expiration
    #
    config_accessor(:jwt_token_exp) { 1.hour.from_now }
    config_accessor(:refresh_token_exp) { 1.month.from_now }
  end
end
