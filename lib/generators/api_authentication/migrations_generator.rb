# frozen_string_literal: true

module ApiAuthentication
  module Generators
    class MigrationsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../../templates', __FILE__)

      def self.next_migration_number(path)
        @time ||= Time.now.utc
        @calls ||= -1
        @calls += 1
        (@time + @calls.seconds).strftime('%Y%m%d%H%M%S')
      end

      def copy_migration
        add_migration(:create_api_auth_users, :app_user_model_class_name)
        add_migration(:create_api_auth_refresh_tokens, :app_refresh_token_model_class_name)
        add_migration(:create_api_auth_push_tokens, :app_push_token_model_class_name)
      end

      private

      def add_migration(template, config_field)
        return if ApiAuthentication.configuration.public_send(config_field).nil?

        migration_template "#{template}.rb", "db/migrate/#{template}.rb"
      end
    end
  end
end