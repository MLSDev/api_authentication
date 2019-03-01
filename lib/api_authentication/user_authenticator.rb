# frozen_string_literal: true

module ApiAuthentication
  class UserAuthenticator
    def initialize(params)
      @email = params[:email]
      @password = params[:password]
      @headers = params[:headers]
    end

    def auth
      access_token = JsonWebToken.encode(access_token_payload)
      refresh_token = user.refresh_tokens.create(token: SecureRandom.base58(100))

      { access_token: access_token, refresh_token: refresh_token.token }
    end

    def user
      @user ||= ApiAuthentication.user_model.find_by(email: email)

      return @user if @user&.authenticate(password)

      raise ApiAuthentication::Auth::InvalidCredentials, I18n.t('api_authentication.errors.auth.invalid_credentials')
    end

    private

    attr_reader :email, :password

    def access_token_payload
      { user_id: user.id }
    end
  end
end
