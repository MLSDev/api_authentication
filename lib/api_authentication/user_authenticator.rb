# frozen_string_literal: true

module ApiAuthentication
  class UserAuthenticator
    def initialize(params)
      @email = params[:email]
      @password = params[:password]
      @request = params[:request]
    end

    def auth
      { access_token: JsonWebToken.encode(access_token_payload) }.merge(refresh_token)
    end

    def user
      @user ||= ApiAuthentication.user_model.find_by(email: email)

      return @user if @user&.authenticate(password)

      raise ApiAuthentication::Auth::InvalidCredentials, I18n.t('api_authentication.errors.auth.invalid_credentials')
    end

    private

    attr_reader :email, :password, :request

    def access_token_payload
      { user_id: user.id }
    end

    def refresh_token
      refresh_token = RefreshTokenCreator.new(user: user, request: request).create
      refresh_token.present? ? { refresh_token: refresh_token.token } : {}
    end
  end
end
