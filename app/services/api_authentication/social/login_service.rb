class ApiAuthentication::Social::LoginService
  attr_reader :social_login_provider, :access_token, :service

  delegate :user, :valid?, :error_response, to: :service, allow_nil: false

  def initialize session
    @social_login_provider = session.social_login_provider
    @access_token          = session.access_token
    # twitter could require other tokens
  end

  private

  def service
    return @service if @service

    case social_login_provider
    when 'facebook'
      @service = ApiAuthentication::Social::FacebookLoginService.new access_token
    when 'twitter'
      # write me later
    end

    @service
  end
end
