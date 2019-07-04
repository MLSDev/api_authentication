# frozen_string_literal: true

module ApiAuthentication
  module SocialProviders
    class Facebook
      BASE_URL = 'https://graph.facebook.com/me'

      attr_reader :access_token

      def initialize(access_token, fields)
        @access_token = access_token
        @fields = fields
      end

      def fetch_data
        check_error
        user_data
      end

      private

      def response
        @response ||= JSON.parse(Net::HTTP.get(url))
      end

      def url
        @url ||= URI("#{BASE_URL}?access_token=#{access_token}&fields=id,#{fields.join(',')}")
      end

      def check_error
        raise ApiAuthentication::Errors::SocialLogin::FacebookError, response['error'] if response['error']
      end

      def user_data
        {
          id: response['id'],
          email: response['email'],
          first_name: response['first_name'],
          last_name: response['last_name'],
          username: response['name'],
          birthday: response['birthday'],
          avatar: response.dig('picture', 'data', 'url')
        }
      end
    end
  end
end
