# frozen_string_literal: true

module ApiAuthentication
  module RequestAuthorizeable
    extend ActiveSupport::Concern

    included do
      before_action :check_base_policy

      attr_reader :current_user

      protect_from_forgery with: :exception, unless: -> { request.format.json? }
    end

    private

    def authenticate!
      @current_user = RequestAuthorizer.new(request.headers).auth
    end

    def base_policy
      true
    end

    def check_base_policy
      head :forbidden unless base_policy
    end
  end
end
