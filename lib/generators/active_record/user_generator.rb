# frozen_string_literal: true

require 'rails/generators/active_record'
require 'generators/api_authentication/model_helpers'

module ActiveRecord
  module Generators
    class UserGenerator < ActiveRecord::Generators::Base
      include ApiAuthentication::Generators::ModelHelpers

      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      source_root File.expand_path('../templates/user', __FILE__)

      def copy_model_migration
        migration_template 'migration.rb', "#{db_migrate_path}/api_authentication_create_#{table_name}.rb", migration_version: migration_version
      end

      def generate_model
        invoke 'active_record:model', [name], migration: false unless model_exists? && behavior == :invoke
      end

      def inject_user_content
        content = model_content

        class_path = if namespaced?
                       class_name.to_s.split('::')
                     else
                       [class_name]
                     end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| '  ' * indent_depth + line } .join("\n") << "\n"

        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
      <<RUBY
      t.string :email, null: false, default: ''
      t.string :password_digest, null: false, default: ''

      # Social Login
      # t.string :facebook_id
RUBY
      end

      def model_content
        <<-CONTENT
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 6 }, allow_nil: true
        CONTENT
      end
    end
  end
end
