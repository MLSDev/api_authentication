# frozen_string_literal: true

class CreateApiAuthPushTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :push_tokens do |t|
      t.references :user, index: true, foreign_key: { to_table: :users }
      t.string :token, null: false, default: ''
      t.integer :device_type, null: false, default: 0
      t.timestamps null: false
    end
  end
end
