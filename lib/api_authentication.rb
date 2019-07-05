# frozen_string_literal: true

require 'api_authentication/configuration'
require 'api_authentication/engine'

module ApiAuthentication
  autoload :HeaderAuthFinder, 'api_authentication/header_auth_finder'
  autoload :JsonWebToken, 'api_authentication/json_web_token'
  autoload :RefreshAccessToken, 'api_authentication/refresh_access_token'
  autoload :RefreshAuthorizer, 'api_authentication/refresh_authorizer'
  autoload :RefreshTokenCreator, 'api_authentication/refresh_token_creator'
  autoload :RequestAuthorizer, 'api_authentication/request_authorizer'
  autoload :UserAuthenticator, 'api_authentication/user_authenticator'
  autoload :SocialLogin, 'api_authentication/social_login'

  module Models
    autoload :User, 'api_authentication/models/user'
    autoload :RefreshToken, 'api_authentication/models/refresh_token'
    autoload :PushToken, 'api_authentication/models/push_token'
  end

  module SocialProviders
    autoload :Facebook, 'api_authentication/social_providers/facebook'
  end

  module Errors
    autoload :Auth, 'api_authentication/errors/auth'
    autoload :SocialLogin, 'api_authentication/errors/social_login'
    autoload :Token, 'api_authentication/errors/token'
  end

  def self.configure(&block)
    block.call configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.user_model_params(user_model)
    configuration.auth_models.find { |auth_model| auth_model[:model] == user_model.name }
  end

  def self.refresh_token_model
    configuration.app_refresh_token_model_class_name.constantize
  end

  def self.push_token_model
    configuration.app_push_token_model_class_name.constantize
  end

  def self.user_field_defined?(model, field)
    user_model_params(model).fetch(:registration_fields).include?(field)
  end
end
