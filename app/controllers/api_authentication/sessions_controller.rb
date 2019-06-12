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
      @resource = ::ApiAuthentication::UserAuthenticator.new(resource_params.merge(request: request))
    end

    def resource
      @resource ||= ApiAuthentication::RefreshAuthorizer.new(request.headers).auth
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end
  end
end
