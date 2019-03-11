# frozen_string_literal: true

require 'rails/generators/active_record'
require 'generators/api_authentication/model_helpers'

module ActiveRecord
  module Generators
    class RefreshTokenGenerator < ActiveRecord::Generators::Base
      include ApiAuthentication::Generators::ModelHelpers

      MODEL_NAME = 'RefreshToken'

      argument :name, type: :string, default: MODEL_NAME, required: false
      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      class_option :user_model_name, type: :string, default: 'user'
      class_option :users_table, type: :string, default: 'users'

      source_root File.expand_path('../templates/refresh_token', __FILE__)

      def copy_model_migration
        migration_template 'migration.rb', "#{db_migrate_path}/api_authentication_create_#{table_name}.rb", migration_version: migration_version
      end

      def generate_model
        invoke 'active_record:model', [name], migration: false unless model_exists? && behavior == :invoke
      end

      def inject_refresh_token_content
        inject_content_for(class_name, refresh_token_content)
      end

      def migration_data
      <<RUBY
      t.references :user, index: true, foreign_key: options[:users_table]
      t.string :token, null: false, default: ''
      t.datetime :expired_at, null: false
      t.string :ip_address, null: false, default: ''
      t.string :user_agent, null: false, default: ''
RUBY
      end

      def refresh_token_content
        <<-CONTENT
  belongs_to #{tokens_user_relation}

  validates :token, :expired_at, :ip_address, :user_agent, presence: true
        CONTENT
      end

      def user_content
        <<-CONTENT
  has_many :#{name.pluralize}
        CONTENT
      end

      def tokens_user_relation
        relation_options = nil

        if user_model_name_namespaced?
          relation_options = ", class_name: #{user_model_name.constantize}.name, foreign_key: 'user_id'"
        end

        ":user#{relation_options}"
      end

      def user_model_name
        @user_model_name ||= options[:user_model_name]
      end

      def user_model_name_namespaced?
        user_model_name.include?('::')
      end
    end
  end
end
