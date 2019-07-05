# frozen_string_literal: true

module ApiAuthentication
  module Models
    module RefreshToken
      extend ActiveSupport::Concern

      included do
        belongs_to :user,
                   if ApiAuthentication.configuration.auth_models.count > 1
                     { polymorphic: true }
                   else
                     { class_name: ApiAuthentication.configuration.auth_models.first[:model] }
                   end

        validates :expired_at, :ip_address, :user_agent, presence: true
        validates :token, uniqueness: true
      end

      class_methods do
        def generate_token
          SecureRandom.base58(100)
        end
      end

      def expired?
        expired_at <= DateTime.current
      end

      def revoked?
        revoked_at.present?
      end

      def revoke!
        update!(revoked_at: DateTime.current)
      end
    end
  end
end
