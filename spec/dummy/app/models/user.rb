# frozen_string_literal: true

class User < ApplicationRecord
  include ApiAuthentication::Models::User
end
