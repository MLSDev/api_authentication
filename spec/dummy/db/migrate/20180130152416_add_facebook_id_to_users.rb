class AddFacebookIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column ApiAuthentication.configuration.users_table_name, :facebook_id, :string
  end
end
