# frozen_string_literal: true

module ApiAuthentication
  module Facebook
    class SessionsController < BaseController
      skip_before_action :authenticate!, only: :create

      attr_reader :resource

      def create
        build_resource
        @resource.call
        @resource = @resource.tokens
      end

      private

      def build_resource
        @resource = ::ApiAuthentication::SocialLogin.new resource_params
      end

      def resource_params
        permitted = params.require(:session).permit(:access_token)
        permitted[:provider] = :facebook
        permitted[:request] = request
        permitted
      end
    end
  end
end
