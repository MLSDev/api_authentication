class User < ApplicationRecord
  include ApiAuthentication::Models::User
end