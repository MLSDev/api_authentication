# frozen_string_literal: true

module ApiAuthentication
  module JsonWebToken
    class Base
      HMAC_SECRET = ApiAuthentication.configuration.secret_key

      def self.encode(payload, exp)
        payload[:exp] = exp.to_i
        JWT.encode(payload, hmac_secret)
      end

      def self.decode(token)
        body = JWT.decode(token, hmac_secret)[0]
        HashWithIndifferentAccess.new(body)
      rescue JWT::DecodeError => e
        raise ApiAuthentication::Token::Invalid, e.message
      end

      private_class_method :hmac_secret

      def self.hmac_secret
        HMAC_SECRET
      end
    end
  end
end