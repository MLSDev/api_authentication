# frozen_string_literal: true

module ApiAuthentication
  class SocialLogin
    attr_reader :provider, :access_token, :user

    def initialize(params)
      @provider = params[:provider]
      @access_token = params[:access_token]
    end

    def save!
      @user = existing_user || new_user

      ApiAuthentication.configuration.registration_fields.each do |field|
        @user[field] = provider_data[field]
      end

      @user.save!
    end

    private

    def provider_data
      @provider_data ||= "#{SocialProviders.name}::#{provider.capitalize}".constantize.new(access_token).fetch_data
    end

    def existing_user
      @existing_user ||= ApiAuthentication.user_model.find_by("#{provider}_id": provider_data[:id])
      @existing_user ||= ApiAuthentication.user_model.find_by(email: provider_data[:email]) if provider_data[:email]
    end

    def new_user
      ApiAuthentication.user_model.new("#{provider}_id": provider_data[:id])
    end
  end
end
