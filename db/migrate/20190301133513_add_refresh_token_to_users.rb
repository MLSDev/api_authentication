class AddRefreshTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column ApiAuthentication.configuration.users_table_name, :refresh_token, :string
  end
end
