# frozen_string_literal: true

module ApiAuthentication
  class RequestAuthorizer
    def initialize(headers = {})
      @header_auth_finder = HeaderAuthFinder.new(headers)
    end

    def auth
      @user ||= ApiAuthentication.user_model.find_by!(id: decoded_auth_token[:user_id])
    rescue ActiveRecord::RecordNotFound => _e
      raise ApiAuthentication::Token::Invalid, I18n.t('api_authentication.errors.token.invalid')
    end

    private

    attr_reader :header_auth_finder

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(header_auth_finder.authorization)
    end
  end
end

