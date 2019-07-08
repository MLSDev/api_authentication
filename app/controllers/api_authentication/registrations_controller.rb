# frozen_string_literal: true

module ApiAuthentication
  class RegistrationsController < BaseController
    attr_reader :resource
    skip_before_action :authenticate!

    private

    def build_resource
      @resource = auth_user_model.new(resource_params)
    end

    def resource_params
      params
        .require(auth_user_model.name.downcase)
        .permit(ApiAuthentication.user_model_params(auth_user_model).fetch(:registration_fields))
    end
  end
end
