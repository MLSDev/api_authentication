# frozen_string_literal: true

class CreateApiAuthUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest, null: false
      t.string :username, null: false
      t.date :birthday, null: false
    end

    add_index :users, :email, unique: true
  end
end
