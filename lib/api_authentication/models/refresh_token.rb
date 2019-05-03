# frozen_string_literal: true

module ApiAuthentication
  module Models
    class RefreshToken
      extend ActiveSupport::Concern

      included do
        belongs_to ApiAuthentication.configuration.app_user_model_class_name.downcase

        validates :expired_at, :ip_address, :user_agent, presence: true
        validates :token, uniqueness: true
      end

      class_methods do
        def generate_token
          SecureRandom.base58(100)
        end
      end
    end
  end
end