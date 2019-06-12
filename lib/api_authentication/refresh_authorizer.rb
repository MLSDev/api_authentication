# frozen_string_literal: true

module ApiAuthentication
  class RefreshAuthorizer
    def initialize(headers = {})
      @header_auth_finder = HeaderAuthFinder.new(headers)
    end

    def auth
      @token ||= ApiAuthentication.refresh_token_model.find_by(token: header_auth_finder.authorization)
      return if @token.present? && !(@token.expired? || @token.revoked?)

      raise ApiAuthentication::Token::Invalid, I18n.t('api_authentication.errors.token.invalid')
    end

    private

    attr_reader :header_auth_finder
  end
end
