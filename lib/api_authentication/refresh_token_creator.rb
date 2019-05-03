# frozen_string_literal: true

module ApiAuthentication
  class RefreshTokenCreator
    def initialize(params)
      @user = params[:user]
      @request = params[:request]
    end

    def create
      return unless ApiAuthentication.configuration.app_refresh_token_model_class_name

      ApiAuthentication.refresh_token_model.create!(
        user_id: user.id,
        token: ApiAuthentication.refresh_token_model.generate_token,
        expired_at: ApiAuthentication.configuration.refresh_token_exp,
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
      )
    end

    private

    attr_reader :request
  end
end
