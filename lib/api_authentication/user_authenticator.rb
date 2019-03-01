# frozen_string_literal: true

module ApiAuthentication
  class UserAuthenticator
    def initialize(email, password = nil)
      @email = email
      @password = password
    end

    def auth
      JsonWebToken::Creator.new(user).create
    end

    def user
      @user ||= ApiAuthentication.user_model.find_by(email: email)

      return @user if @user&.authenticate(password)

      raise ApiAuthentication::Auth::InvalidCredentials, I18n.t('api_authentication.errors.auth.invalid_credentials')
    end

    private

    attr_reader :email, :password
  end
end
