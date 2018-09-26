require 'rails_helper'

describe ApiAuthentication::Configuration do
  its(:users_table_name) { should eq 'users' }
end
