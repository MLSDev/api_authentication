# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token, class: ApiAuthentication.configuration.app_refresh_token_model_class_name do
    token { SecureRandom.hex(5) }
    expired_at { 1.hour.from_now }
    ip_address { FFaker::Internet.ip_v4_address }
    user_agent do
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
      'Chrome/60.0.3112.113 Safari/537.36'
    end
  end
end
