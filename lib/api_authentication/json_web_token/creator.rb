# frozen_string_literal: true

module ApiAuthentication
  module JsonWebToken
    class Creator
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def create
        access_token = Access.encode(access_token_payload)
        refresh_token = Refresh.encode(refresh_token_payload)

        user.update_column(:refresh_token, refresh_token)

        { access_token: access_token, refresh_token: refresh_token }
      end

      private

      def access_token_payload
        { user_id: user.id }
      end

      def refresh_token_payload
        { user_id: user.id }
      end
    end
  end
end
