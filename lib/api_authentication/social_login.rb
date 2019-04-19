# frozen_string_literal: true

module ApiAuthentication
  class SocialLogin
    attr_reader :provider, :access_token

    def initialize(params)
      @provider = params[:provider]
      @access_token = params[:access_token]
    end

    def auth
      (provider == 'facebook') ? SocialProviders::Facebook.new(access_token).auth : raise NotImplementedError
    end
  end
end
