# frozen_string_literal: true

module ApiAuthentication
  module JsonWebToken
    class Access < Base
      def self.encode(payload)
        super(payload, ApiAuthentication.configuration.jwt_token_exp)
      end

      private_class_method :hmac_secret

      def self.hmac_secret
        super + 'access_token'
      end
    end
  end
end
