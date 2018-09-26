class CreateApiAuthenticationSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :api_authentication_sessions do |t|
      t.string :token
      t.string :push_token
      t.string :device_id
      t.string :device_type
      t.boolean :online
      t.bigint :user_id
      t.integer :kind
      t.integer :social_login_provider

      t.timestamps
    end
  end
end
