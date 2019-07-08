# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body).with_indifferent_access
    end
  end
end
