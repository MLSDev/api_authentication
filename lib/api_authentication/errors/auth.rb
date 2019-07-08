# frozen_string_literal: true

module ApiAuthentication
  module Errors
    class Auth
      class InvalidCredentials < StandardError; end
    end
  end
end
