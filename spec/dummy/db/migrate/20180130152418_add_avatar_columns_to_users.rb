class AddAvatarColumnsToUsers < ActiveRecord::Migration[5.1]
  def up
    add_attachment ApiAuthentication.configuration.users_table_name, :avatar
  end

  def down
    remove_attachment ApiAuthentication.configuration.users_table_name, :avatar
  end
end
