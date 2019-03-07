# frozen_string_literal: true

module ApiAuthentication
  module Generators
    class MigrationsGenerator < Rails::Generators::Base

      source_root File.expand_path('../../../../db/migrate/', __FILE__)

      desc "Creates a ApiAuthentication initializer in your application's config/initializers dir"

      def copy_migration_file
        template '20180129212100_create_users.rb', "db/migrate/#{ 2.seconds.from_now.to_s(:number) }_create_users.rb" unless ActiveRecord::Base.connection.table_exists? ApiAuthentication.configuration.users_table_name
        template '20180129212121_create_api_authentication_sessions.rb', "db/migrate/#{ 4.seconds.from_now.to_s(:number) }_create_api_authentication_sessions.rb"
        template '20180129212123_add_created_via_and_provider_to_users.rb', "db/migrate/#{ 6.seconds.from_now.to_s(:number) }_add_created_via_and_provider_to_users.rb"
        template '20180129213142_add_facebook_id_to_users.rb', "db/migrate/#{ 8.seconds.from_now.to_s(:number) }_add_facebook_id_to_users.rb" if ApiAuthentication.configuration.include_facebook_login
        template '20180130120441_add_avatar_columns_to_users.rb', "db/migrate/#{ 10.seconds.from_now.to_s(:number) }_add_avatar_columns_to_users.rb" if ApiAuthentication.configuration.add_avatar_fields
      end
    end
  end
end
