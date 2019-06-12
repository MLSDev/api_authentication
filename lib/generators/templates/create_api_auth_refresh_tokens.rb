# frozen_string_literal: true

class CreateApiAuthRefreshTokens < ActiveRecord::Migration<%= "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" %>
  def change
    create_table :<%= ApiAuthentication.configuration.app_refresh_token_model_class_name.underscore.pluralize %> do |t|
      t.references :user, index: true, foreign_key: { to_table: :<%= ApiAuthentication.configuration.app_user_model_class_name.underscore.pluralize %> }
      t.string :token, null: false, default: ''
      t.datetime :expired_at, null: false
      t.datetime :revoked_at
      t.string :ip_address, null: false, default: ''
      t.string :user_agent, null: false, default: ''
      t.timestamps null: false
    end

    add_index :<%= ApiAuthentication.configuration.app_refresh_token_model_class_name.underscore.pluralize %>, :token, unique: true
  end
end