# frozen_string_literal: true

module ApiAuthentication
  class RefreshTokenCreator
    def initialize(params)
      @user = params[:user]
      @request = params[:request]
    end

    def create
      ApiAuthentication.refresh_token_model.create!(
        user_id: user.id,
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
