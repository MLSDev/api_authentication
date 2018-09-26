require 'rails_helper'

describe ApiAuthentication::User do
  it { should be_a ApiAuthentication::ApplicationRecord }

  it { should have_secure_password }

  it { should have_many :sessions }

  it { should have_one :latest_session }

  describe '.table_name with default config' do
    it { expect(described_class.table_name).to eq ApiAuthentication.configuration.users_table_name }
  end
end
