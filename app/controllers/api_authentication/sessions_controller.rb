# frozen_string_literal: true

module ApiAuthentication
  class SessionsController < BaseController
    skip_before_action :authenticate!, only: :create

    def destroy
      current_session.destroy!

      head :no_content
    end

    def update
      current_session.update! update_params

      head :ok
    end

    private

    def resource
      @session
    end

    def build_resource
      @session = ApiAuthentication::Session.email_login.new resource_params
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end

    def update_params
      params.require(:session).permit(:push_token, :device_type)
    end
  end
end