# frozen_string_literal: true

require 'rails_helper'

describe RefreshToken, type: :model do
  it_behaves_like 'api_auth_refresh_token'
end
