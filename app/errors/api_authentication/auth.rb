# frozen_string_literal: true

module ApiAuthentication
  class Auth
    class InvalidCredentials < StandardError; end
    class FacebookError < StandardError; end
  end
end
