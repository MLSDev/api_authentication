# frozen_string_literal: true

module ApiAuthentication
  module Models
    module User
      extend ActiveSupport::Concern

      EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

      included do
        has_secure_password

        if ApiAuthentication.configuration.app_refresh_token_model_class_name
          has_many ApiAuthentication.configuration.app_refresh_token_model_class_name.pluralize.underscore.to_sym
        end

        if ApiAuthentication.configuration.app_push_token_model_class_name
          has_many ApiAuthentication.configuration.app_push_token_model_class_name.pluralize.underscore.to_sym
        end

        validates :email, format: { with: EMAIL_REGEX } if ApiAuthentication.user_field_defined?(:email)
        validates :first_name, presence: true if ApiAuthentication.user_field_defined?(:first_name)
        validates :last_name, presence: true if ApiAuthentication.user_field_defined?(:last_name)
        validates :username, presence: true if ApiAuthentication.user_field_defined?(:username)
        validates :birthday, presence: true if ApiAuthentication.user_field_defined?(:birthday)
      end
    end
  end
end
