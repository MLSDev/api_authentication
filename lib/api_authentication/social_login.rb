# frozen_string_literal: true

module ApiAuthentication
  class SocialLogin
    attr_reader :provider, :access_token, :user, :tokens, :request, :user_model

    def initialize(params)
      @provider = params[:provider]
      @access_token = params[:access_token]
      @request = params[:request]
      @user_model = params[:user_model]
    end

    def call
      raise ApiAuthentication::Errors::SocialLogin::NotAllowed unless social_login_allowed?

      save_info!
      create_tokens!
    end

    private

    def save_info!
      @user = existing_user || new_user
      @user.persisted? ? update_existing_user : create_new_user
    end

    def create_tokens!
      @tokens = ApiAuthentication::UserAuthenticator.new(user: user, request: request).auth
    end

    def provider_data
      @provider_data ||= "#{SocialProviders.name}::#{provider.capitalize}"
        .constantize.new(access_token, registration_fields).fetch_data
    end

    def existing_user
      @existing_user ||= user_model.find_by("#{provider}_id": provider_data[:id])
      @existing_user ||= user_model.find_by(email: provider_data[:email]) if provider_data[:email]
    end

    def new_user
      user_model.new("#{provider}_id": provider_data[:id], password: SecureRandom.uuid)
    end

    def update_existing_user
      @user.update_column("#{provider}_id", provider_data[:id])
    end

    def create_new_user
      registration_fields.each do |field|
        @user[field] ||= provider_data[field]
      end

      @user.save!
    end

    def registration_fields
      user_model_params.fetch("#{provider}_registration_fields").reject { |f| f == :password }
    end

    def user_model_params
      @user_model_params ||= ApiAuthentication.user_model_params(user_model)
    end

    def social_login_allowed?
      user_model_params.fetch(:social_login)
    end
  end
end
