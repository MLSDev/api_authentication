# frozen_string_literal: true

module ApiAuthentication
  class UserAuthenticator
    def initialize(params)
      @user = params[:user]
      @email = params[:email]
      @password = params[:password]
      @request = params[:request]
    end

    def auth
      { access_token: JsonWebToken.encode(access_token_payload) }.merge(refresh_token)
    end

    def user
      return if @user

      @user = ApiAuthentication.user_model.find_by(email: email)
      return @user if @user&.authenticate(password)

      raise ApiAuthentication::Auth::InvalidCredentials, I18n.t('api_authentication.errors.auth.invalid_credentials')
    end

    private

    attr_reader :email, :password, :request

    def access_token_payload
      { user_id: user.id }
    end

    def refresh_token
      return {} unless ApiAuthentication.configuration.app_refresh_token_model_class_name

      { refresh_token: RefreshTokenCreator.new(user: user, request: request).create.token }
    end
  end
end
