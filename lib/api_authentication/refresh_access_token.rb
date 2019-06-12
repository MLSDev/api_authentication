# frozen_string_literal: true

module ApiAuthentication
  class RefreshAccessToken
    attr_reader :headers, :tokens

    def initialize(headers)
      @headers = headers
    end

    def call
      create_new_tokens!
      revoke_refresh_token!
    end

    private

    def refresh_token
      @refresh_token ||= ApiAuthentication::RefreshAuthorizer.new(request.headers).auth
    end

    def create_new_tokens!
      @tokens = ApiAuthentication::UserAuthenticator.new(user: refresh_token.user).auth
    end

    def revoke_refresh_token!
      refresh_token.revoke!
    end
  end
end