# frozen_string_literal: true

module ApiAuthentication
  class RefreshTokenCreator
    def initialize(params)
      @user = params[:user]
      @request = params[:request]
    end

    def create
      user.refresh_tokens.create!(
        token: ApiAuthentication.refresh_token_model.generate_token,
        expired_at: ApiAuthentication.configuration.refresh_token_exp.from_now,
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
      )
    end

    private

    attr_reader :request, :user
  end
end
