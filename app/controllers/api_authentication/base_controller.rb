class ApiAuthentication::BaseController < ApiAuthentication::ApplicationController
  # skip_before_action :verify_authenticity_token

  before_action :authenticate!

  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  attr_reader :current_user_id, :current_token, :current_jwt_hash

  helper_method :collection, :resource, :parent, :current_user

  rescue_from ActionController::ParameterMissing do |exception|
    @exception = exception

    render :exception, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    render :errors, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  def create
    build_resource

    resource.save!
  end

  def update
    resource.update!(resource_params)
  end

  def destroy
    resource.destroy

    head :no_content
  end

  private

  def authenticate!
    authenticate_or_request_with_http_token do |token,|
      begin
        @current_token    = token

        #
        # STRUCTURE: { user: { id: XXX, created_at: 'XXX' } }
        #
        @current_jwt_hash = JWT.decode(token, ENV['JWT_HMAC_SECRET'], true, { algorithm: 'HS256' })
                               .detect { |hash| hash.key?('user') }
                               .deep_symbolize_keys

        @current_user_id  = current_jwt_hash[:user][:id]

      rescue JWT::DecodeError
        false
      end
    end
  end

  def parent
    raise NotImplementedError
  end

  def resource
    raise NotImplementedError
  end

  def resource_params
    raise NotImplementedError
  end

  def build_resource
    raise NotImplementedError
  end

  def collection
    raise NotImplementedError
  end

  def current_user
    @current_user ||= User.find current_user_id
  end

  def current_session
    @current_session ||= ::ApiAuthentication::Session.find_by_token! current_token
  end
end
