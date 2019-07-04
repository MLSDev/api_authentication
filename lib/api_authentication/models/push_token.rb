# frozen_string_literal: true

module ApiAuthentication
  module Models
    module PushToken
      extend ActiveSupport::Concern

      included do
        belongs_to :user,
                   if ApiAuthentication.configuration.auth_models.count > 1
                     { polymorphic: true }
                   else
                     { class_name: ApiAuthentication.configuration.auth_models
                       .first[:model].underscore.downcase.to_sym }
                   end

        validates :token, presence: true

        enum device_type: { android: 0, ios: 1 }
      end
    end
  end
end
