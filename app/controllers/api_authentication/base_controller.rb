# frozen_string_literal: true

module ApiAuthentication
  class BaseController < ApplicationController
    include ApiAuthentication::RequestAuthorizeable
    protect_from_forgery with: :exception, unless: -> { request.format.json? }

    before_action :authenticate!

    helper_method :collection, :resource, :parent

    rescue_from ActionController::ParameterMissing do |exception|
      @exception = exception

      render :exception, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      @errors = error.record.errors

      render :errors, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    def create
      build_resource

      resource.save!
    end

    def update
      resource.update! resource_params
    end

    def destroy
      resource.destroy!

      head :no_content
    end

    private

    def parent
      raise NotImplementedError
    end

    def resource
      raise NotImplementedError
    end

    def resource_params
      raise NotImplementedError
    end

    def build_resource
      raise NotImplementedError
    end

    def collection
      raise NotImplementedError
    end
  end
end
