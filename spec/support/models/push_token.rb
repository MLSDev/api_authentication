# frozen_string_literal: true

shared_examples 'api_auth_push_token' do
  context 'relations' do
    it do
      should belong_to(:user).class_name(ApiAuthentication.configuration.auth_models.first.fetch(:model))
    end
  end

  context 'validations' do
    it { should validate_presence_of(:token) }
  end

  context 'enums' do
    it { should define_enum_for(:device_type).with_values(android: 0, ios: 1) }
  end
end
