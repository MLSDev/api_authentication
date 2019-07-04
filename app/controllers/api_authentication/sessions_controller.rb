# frozen_string_literal: true

module ApiAuthentication
  class SessionsController < BaseController
    skip_before_action :authenticate!

    def create
      build_resource
      @resource = resource.auth
    end

    private

    def build_resource
      @resource = ::ApiAuthentication::UserAuthenticator.new(resource_params)
    end

    def resource
      @resource ||= ApiAuthentication::RefreshAuthorizer.new(request.headers).auth
    end

    def resource_params
      permitted = params.require(:session).permit(:login, :password)
      permitted[:request] = request
      permitted[:user_model] = auth_user_model
    end
  end
end
