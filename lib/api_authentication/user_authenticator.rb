# frozen_string_literal: true

module ApiAuthentication
  class UserAuthenticator
    def initialize(params)
      @user = params[:user]
      @user_model = params[:user_model] || @user&.class
      @login = params[:login]
      @password = params[:password]
      @request = params[:request]
    end

    def auth
      { access_token: JsonWebToken.encode(access_token_payload) }.merge(refresh_token)
    end

    def user
      return @user if @user

      @user = user_model.find_by(login_field => login)
      return @user if @user&.authenticate(password)

      raise ApiAuthentication::Errors::Auth::InvalidCredentials, I18n.t('api_authentication.errors.auth.invalid_credentials')
    end

    private

    attr_reader :user_model, :login, :password, :request

    def access_token_payload
      { user_id: user.id, user_model: user_model.name }
    end

    def refresh_token
      return {} unless ApiAuthentication.configuration.app_refresh_token_model_class_name

      { refresh_token: RefreshTokenCreator.new(user: user, request: request).create.token }
    end

    def login_field
      @login_field ||= ApiAuthentication.user_model_params(user_model).fetch(:login_field)
    end
  end
end
