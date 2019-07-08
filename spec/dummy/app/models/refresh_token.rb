# frozen_string_literal: true

class RefreshToken < ApplicationRecord
  include ApiAuthentication::Models::RefreshToken
end
