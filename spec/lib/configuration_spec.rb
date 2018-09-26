require 'rails_helper'

describe ApiSessionRecovering::Configuration do
  its(:users_table_name) { should eq 'users' }
end
