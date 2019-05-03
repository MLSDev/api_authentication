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

      def fetch_data
        check_error
        user_data
      end

      private

      def response
        @response ||= JSON.parse(Net::HTTP.get(url))
      end

      def url
        @url ||= URI("#{BASE_URL}?access_token=#{access_token}&fields=#{FIELDS}")
      end

      def check_error
        raise ApiAuthentication::Auth::FacebookError, response['error'] if response['error']
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
