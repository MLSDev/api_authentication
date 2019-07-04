# frozen_string_literal: true

module ApiAuthentication
  module Errors
    class Token
      class Missing < StandardError; end
      class Invalid < StandardError; end
    end
  end
end
