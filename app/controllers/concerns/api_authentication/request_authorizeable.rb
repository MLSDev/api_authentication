# frozen_string_literal: true

module ApiAuthentication
  module RequestAuthorizeable
    extend ActiveSupport::Concern

    included do
      attr_reader :current_user

      protect_from_forgery with: :exception, unless: -> { request.format.json? }
    end

    private

    def authenticate!
      @current_user = RequestAuthorizer.new(request.headers).auth
    end

    def auth_user_model
      model = params[:user_model] || ApiAuthentication.configuration.auth_models.first[:model]
      model.constantize
    end
  end
end
