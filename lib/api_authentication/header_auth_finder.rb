# frozen_string_literal: true

module ApiAuthentication
  class HeaderAuthFinder
    def initialize(headers)
      @headers = headers
    end

    def authorization
      return headers['Authorization'].split(' ').last if headers['Authorization'].present?

      raise ApiAuthentication::Token::Missing, I18n.t('api_authentication.errors.token.missing')
    end

    private

    attr_reader :headers
  end
end
