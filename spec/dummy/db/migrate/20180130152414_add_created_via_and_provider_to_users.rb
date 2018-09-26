class AddCreatedViaAndProviderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column ApiAuthentication.configuration.users_table_name, :created_via, :integer, default: 0
    add_column ApiAuthentication.configuration.users_table_name, :created_via_social_provider, :integer

    add_index :users, :created_via
  end
end
