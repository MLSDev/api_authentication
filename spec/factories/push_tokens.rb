# frozen_string_literal: true

FactoryBot.define do
  factory :push_token, class: ApiAuthentication.configuration.app_push_token_model_class_name do
    user
    token { SecureRandom.hex(5) }
    device_type { ApiAuthentication.push_token_model.device_types.keys.sample }
  end
end
