class ApiAuthentication::Facebook::SessionsController < ApiAuthentication::BaseController
  skip_before_action :authenticate!, only: :create

  private
  def build_resource
    @session = ::ApiAuthentication::Session.social_login.facebook.new resource_params
  end

  def resource
    @session
  end

  def resource_params
    params.permit(:access_token)
  end
end
