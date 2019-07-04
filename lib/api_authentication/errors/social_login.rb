# frozen_string_literal: true

module ApiAuthentication
  module Errors
    class SocialLogin
      class NotAllowed < StandardError; end
      class FacebookError < StandardError; end
    end
  end
end
