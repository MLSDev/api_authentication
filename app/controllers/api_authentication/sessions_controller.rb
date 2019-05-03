# frozen_string_literal: true

module ApiAuthentication
  class SessionsController < BaseController
    skip_before_action :authenticate!

    attr_reader :resource

    def create
      build_resource
      @resource = resource.auth
    end

    def destroy
      ApiAuthentication::RefreshAuthorizer.new(request.headers).auth.destroy!

      head :no_content
    end

    private

    def build_resource
      @resource = ::ApiAuthentication::UserAuthenticator.new(resource_params.merge(request: request))
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end
  end
end