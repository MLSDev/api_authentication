# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it_behaves_like 'api_auth_user'
end
