module ApiAuthentication::ActsAsBaseControllerWithAuthentication
  extend ActiveSupport::Concern

  require 'jwt'

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
          if defined?("::#{ ApiAuthentication.configuration.app_user_model_class_name }".constantize)
            "::#{ ApiAuthentication.configuration.app_user_model_class_name }".constantize.find(model.user.id).decorate(context: context).model.class.to_s
          else
            super
          end
        end
      end
    end

    before_action :authenticate!

    before_action :check_base_policy

    helper_method :current_user

    helper_method :current_session

    protect_from_forgery with: :exception, unless: -> { request.format.json? }

    attr_reader :current_user_id, :current_token, :current_jwt_hash
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

      return true
    rescue JWT::DecodeError
      return false
    end
  end

  def current_user
    @current_user ||=
      "::#{ ApiAuthentication.configuration.app_user_model_class_name.constantize }".constantize.find current_user_id
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
