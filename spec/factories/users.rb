# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: ApiAuthentication.configuration.auth_models.first.fetch(:model) do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    username { FFaker::Internet.user_name }
    birthday { Date.current - 18.years }
    password { FFaker::Internet.password }
  end
end
