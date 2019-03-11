# frozen_string_literal: true

module ApiAuthentication
  class SessionsController < BaseController
    skip_before_action :authenticate!, only: :create

    def create
      build_resource
      @resource = resource.auth
    end

    def destroy
      current_user.update_column(:refresh_token, nil)

      head :no_content
    end

    private

    def resource
      @resource ||= build_resource
    end

    def build_resource
      @resource = ::ApiAuthentication::UserAuthenticator.new(resource_params.merge(request: request))
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end
  end
end