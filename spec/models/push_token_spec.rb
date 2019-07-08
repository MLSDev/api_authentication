# frozen_string_literal: true

require 'rails_helper'

describe PushToken, type: :model do
  it_behaves_like 'api_auth_push_token'
end
