# frozen_string_literal: true

module ApiAuthentication
  class RefreshAuthorizer
    def initialize(headers = {})
      @header_auth_finder = HeaderAuthFinder.new(headers)
    end

    def auth
      @user ||= ApiAuthentication.refresh_token_model.find_by!(token: header_auth_finder.authorization).user
    rescue ActiveRecord::RecordNotFound => _e
      raise ApiAuthentication::Token::Invalid, I18n.t('api_authentication.errors.token.invalid')
    end

    private

    attr_reader :header_auth_finder
  end
end
