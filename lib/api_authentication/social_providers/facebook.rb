# frozen_string_literal: true

module ApiAuthentication
  module SocialProviders
    class Facebook
      BASE_URL = 'https://graph.facebook.com/me'
      FIELDS = 'id,email,birthday,name,first_name,last_name,picture.width(300).height(300)'

      attr_reader :access_token

      def initialize(access_token)
        @access_token = access_token
      end

      def auth

      end

      private

      def response
        @response ||= JSON.parse(Net::HTTP.get(url))
      end

      def url
        @url ||= URI("#{BASE_URL}?access_token=#{access_token}&fields=#{FIELDS}")
      end
    end
  end
end
