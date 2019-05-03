# frozen_string_literal: true

class CreateRefreshTokens < ActiveRecord::Migration<%= "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" %>
  def change
    create_table :<%= ApiAuthentication.refresh_token_model.name.underscore.pluralize %> do |t|
      t.references :user, index: true, foreign_key: { to_table: :<%= ApiAuthentication.user_model.name.underscore.pluralize %> }
      t.string :token, null: false, default: ''
      t.datetime :expired_at, null: false
      t.string :ip_address, null: false, default: ''
      t.string :user_agent, null: false, default: ''
      t.timestamps null: false
    end

    add_index :<%= ApiAuthentication.refresh_token_model.name.underscore.pluralize %>, :token, unique: true
  end
end
