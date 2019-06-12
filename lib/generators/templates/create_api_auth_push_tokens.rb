# frozen_string_literal: true

class CreateApiAuthPushTokens < ActiveRecord::Migration<%= "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" %>
  def change
    create_table :<%= ApiAuthentication.configuration.app_push_token_model_class_name.underscore.pluralize %> do |t|
      t.references :user, index: true, foreign_key: { to_table: :<%= ApiAuthentication.configuration.app_user_model_class_name.underscore.pluralize %> }
      t.string :token, null: false, default: ''
      t.integer :device_type, null: false, default: 0
      t.timestamps null: false
    end
  end
end