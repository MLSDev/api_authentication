# frozen_string_literal: true

module ApiAuthentication
  module SocialProviders
    class Facebook
      BASE_URL = 'https://graph.facebook.com/me'
      FIELDS_EQUALITY = {
        email: :email,
        first_name: :first_name,
        last_name: :last_name,
        username: :name,
        birthday: :birthday,
        avatar: 'picture.width(300).height(300)'
      }.freeze

      attr_reader :access_token, :fields

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
        @url ||= URI("#{BASE_URL}?access_token=#{access_token}&fields=#{fetch_fields}")
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

      def fetch_fields
        ([:id] + fields.map { |f| FIELDS_EQUALITY[f] }).join(',')
      end
    end
  end
end
