# frozen_string_literal: true

shared_examples 'api_auth_push_token' do
  context 'relations' do
    it { should belong_to(ApiAuthentication.configuration.app_user_model_class_name.downcase.to_sym) }
  end

  context 'validations' do
    it { should validate_presence_of(:token) }
  end

  context 'enums' do
    it { should define_enum_for(:device_type).with_values(android: 0, ios: 1) }
  end
end
