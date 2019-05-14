# frozen_string_literal: true

class CreateApiAuthRefreshTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :refresh_tokens do |t|
      t.references :user, index: true, foreign_key: { to_table: :users }
      t.string :token, null: false, default: ''
      t.datetime :expired_at, null: false
      t.string :ip_address, null: false, default: ''
      t.string :user_agent, null: false, default: ''
      t.timestamps null: false
    end

    add_index :refresh_tokens, :token, unique: true
  end
end
