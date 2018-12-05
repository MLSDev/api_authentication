class ApiAuthentication::Facebook::SessionsController < ApiAuthentication::BaseController
  skip_before_action :authenticate!, only: :create

  attr_reader :resource

  private

  def build_resource
    @resource = ::ApiAuthentication::Session.social_login.facebook.new resource_params
  end

  def resource_params
    params.permit(:access_token)
  end
end
