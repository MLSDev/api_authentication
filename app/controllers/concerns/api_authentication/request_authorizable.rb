# frozen_string_literal: true

module ApiAuthentication
  module RequestAuthorizeable
    extend ActiveSupport::Concern

    included do
      if defined?("::#{ ApiAuthentication.configuration.app_user_model_class_name.constantize }Decorator".constantize)
        unless defined?(::ApiAuthentication::UserDecorator)
          class ::ApiAuthentication::UserDecorator < "::#{ ApiAuthentication.configuration.app_user_model_class_name.constantize }Decorator".constantize; end
        end
      end

      unless defined?(::ApiAuthentication::SessionDecorator)
        class ApiAuthentication::SessionDecorator < Draper::Decorator
          delegate_all

          def as_json *args
            {
              token: token,
              user:  user
            }
          end

          def user
            "::#{ ApiAuthentication.configuration.app_user_model_class_name }".constantize.find(model.user.id).decorate context: context
          rescue
            #
            # NOTE: case when UserDecorator is not loaded yet - will be use the decorator from the engine
            #
            super
          end
        end
      end

      before_action :check_base_policy

      helper_method :current_user

      protect_from_forgery with: :exception, unless: -> { request.format.json? }
    end

    private

    def authenticate!
      authenticate_or_request_with_http_token do |token,|
        decode_jwt_hash_by token
      end
    end

    def authenticate
      authenticate_with_http_token do |token,|
        decode_jwt_hash_by token
      end
    end

    def decode_jwt_hash_by token
      begin
        @current_token    = token

        #
        # STRUCTURE: { user: { id: XXX, created_at: 'XXX' } }
        #
        @current_jwt_hash = ::JWT.decode(token, ENV['JWT_HMAC_SECRET'], true, { algorithm: 'HS256' })
                              .detect { |hash| hash.key?('user') }
                              .deep_symbolize_keys

        @current_user_id  = current_jwt_hash[:user][:id]

        @current_session_created_at = current_jwt_hash[:user][:created_at].to_datetime

        #
        # TODO: incapsulate me
        #
        if ApiAuthentication.configuration.handle_users_is_blocked
          #
          # is_blocked
          #
          if current_user_with_only_block_data.respond_to?(:is_blocked) && current_user_with_only_block_data.is_blocked?
            return false
          end

          #
          # is_blocked_at
          #
          if \
          current_user_with_only_block_data.respond_to?(:is_blocked_at) &&              # need to be sure that user blocking was implemented on the back-end side
            current_user_with_only_block_data.is_blocked_at               &&              # if there was any value
            current_user_with_only_block_data.is_blocked_at > current_session_created_at  # if user was banned after session was created - consider that session as blocked
            return false
          end
        end

        return true
      rescue JWT::DecodeError
        return false
      end
    end

    def current_user
      @current_user ||=
        "::#{ ApiAuthentication.configuration.app_user_model_class_name.constantize }".constantize.find current_user_id
    end

    def current_user_with_only_block_data
      @current_user_with_only_block_data ||=
        "::#{ ApiAuthentication.configuration.app_user_model_class_name.constantize }".
          constantize.
          select(:is_blocked, :is_blocked_at).
          find current_user_id
    end

    def current_session
      @current_session ||= ::ApiAuthentication::Session.find_by_token! current_token
    end

    def base_policy
      true
    end

    def check_base_policy
      head :forbidden unless base_policy
    end
  end
end
