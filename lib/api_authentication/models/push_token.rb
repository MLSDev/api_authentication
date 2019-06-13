# frozen_string_literal: true

module ApiAuthentication
  module Models
    module PushToken
      extend ActiveSupport::Concern

      included do
        belongs_to ApiAuthentication.configuration.app_user_model_class_name.downcase.to_sym

        validates :token, presence: true

        enum device_type: { android: 0, ios: 1 }
      end
    end
  end
end
