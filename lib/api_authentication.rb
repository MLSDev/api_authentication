require 'api_authentication/configuration'
require 'api_authentication/engine'
require 'apidocs/session_docs'

module ApiAuthentication
  autoload :HeaderAuthFinder, 'api_authentication/header_auth_finder'
  autoload :JsonWebToken, 'api_authentication/json_web_token'
  autoload :RefreshAuthorizer, 'api_authentication/refresh_authorizer'
  autoload :RefreshTokenCreator, 'api_authentication/refresh_token_creator'
  autoload :RequestAuthorizer, 'api_authentication/request_authorizer'
  autoload :UserAuthenticator, 'api_authentication/user_authenticator'

  module Models
    autoload :User, 'api_authentication/models/user'
    autoload :RefreshToken, 'api_authentication/models/refresh_token'
    autoload :PushToken, 'api_authentication/models/push_token'
  end

  SWAGGER_CLASSES = [
    ::ApiAuthentication::SessionDocs
  ]

  def self.configure(&block)
    block.call configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.user_model
    configuration.app_user_model_class_name.constantize
  end

  def self.refresh_token_model
    configuration.app_refresh_token_model_class_name.constantize
  end

  def self.user_field_defined?(field)
    configuration.user_fields.include?(field)
  end
end
