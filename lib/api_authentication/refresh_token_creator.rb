# frozen_string_literal: true

module ApiAuthentication
  class RefreshTokenCreator
    def initialize(params)
      @user = params[:user]
      @request = params[:request]
    end

    def create
      return unless ApiAuthentication.configuration.include_refresh_token

      user.refresh_tokens.create!(
        token: SecureRandom.base58(100),
        expired_at: ApiAuthentication.configuration.refresh_token_exp,
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
      )
    end

    private

    attr_reader :request
  end
end
