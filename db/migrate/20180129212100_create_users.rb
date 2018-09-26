class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table ApiAuthentication.configuration.users_table_name do |t|
      t.string :first_name if ApiAuthentication.configuration.add_first_name_field
      t.string :last_name if ApiAuthentication.configuration.add_last_name_field
      t.string :email
      t.string :password_digest
      t.boolean :online
      t.string :full_name if ApiAuthentication.configuration.add_full_name_field
      t.string :username if ApiAuthentication.configuration.add_username_field
      t.string :birthday if ApiAuthentication.configuration.add_birthday_field

      t.timestamps
    end
  end
end
