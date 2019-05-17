# frozen_string_literal: true

require 'jwt'

module ApiAuthentication
  class JsonWebToken
    HMAC_SECRET = ApiAuthentication.configuration.secret_key

    def self.encode(payload)
      payload[:exp] = ApiAuthentication.configuration.jwt_token_exp.from_now.to_i
      JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError => e
      raise ApiAuthentication::Token::Invalid, e.message
    end
  end
end
