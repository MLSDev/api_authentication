# frozen_string_literal: true

module ApiAuthentication
  module JsonWebToken
    class Refresh < Base
      def self.encode(payload)
        super payload, ApiAuthentication.configuration.refresh_token_exp
      end

      private_class_method :hmac_secret

      def self.hmac_secret
        super + 'refresh_token'
      end
    end
  end
end
