# frozen_string_literal: true

module ApiAuthentication
  module Models
    module User
      extend ActiveSupport::Concern

      EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

      included do
        has_secure_password

        if ApiAuthentication.user_model_params(self).fetch(:refresh_tokens)
          has_many ApiAuthentication.configuration.app_refresh_token_model_class_name.pluralize.underscore.to_sym,
                   as: ApiAuthentication.configuration.auth_models.count > 1 ? :user : nil
        end

        if ApiAuthentication.user_model_params(self).fetch(:push_tokens)
          has_many ApiAuthentication.configuration.app_push_token_model_class_name.pluralize.underscore.to_sym,
                   as: ApiAuthentication.configuration.auth_models.count > 1 ? :user : nil
        end

        validates :email, format: { with: EMAIL_REGEX } if ApiAuthentication.user_field_defined?(self, :email)
        validates :first_name, presence: true if ApiAuthentication.user_field_defined?(self, :first_name)
        validates :last_name, presence: true if ApiAuthentication.user_field_defined?(self, :last_name)
        validates :username, presence: true if ApiAuthentication.user_field_defined?(self, :username)
        validates :birthday, presence: true if ApiAuthentication.user_field_defined?(self, :birthday)
      end
    end
  end
end
