# frozen_string_literal: true

module ApiAuthentication
  class RegistrationsController < BaseController
    private

    def build_resource
      @resource = ApiAuthentication.user_model.new(resource_params)
    end

    def resource
      @resource ||= build_resource
    end

    def resource_params
      params
        .require(ApiAuthentication.user_model.name.downcase)
        .permit(ApiAuthentication.configuration.registration_fields)
    end
  end
end
