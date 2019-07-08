# frozen_string_literal: true

module ApiAuthentication
  class AccessTokensController < BaseController
    skip_before_action :authenticate!

    attr_reader :resource

    def create
      build_resource
      @resource.call
      @resource = @resource.tokens
    end

    private

    def build_resource
      @resource = ApiAuthentication::RefreshAccessToken.new(request)
    end
  end
end
