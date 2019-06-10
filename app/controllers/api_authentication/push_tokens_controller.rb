# frozen_string_literal: true

module ApiAuthentication
  class PushTokensController < BaseController
    private

    def build_resource
      @resource = current_user.push_tokens.build(resource_params)
    end

    def resource
      @resource ||= current_user.push_tokens.find_by!(token: params[:token])
    end

    def resource_params
      params.require(:push_token).permit(:token, :device_type)
    end
  end
end
