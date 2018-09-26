FactoryBot.define do
  factory :user, class: ApiAuthentication::User do
    password Faker::Internet.password

    email    Faker::Internet.email
  end
end
