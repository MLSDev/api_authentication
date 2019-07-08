# frozen_string_literal: true

module ApiAuthentication
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      desc "Creates a ApiAuthentication initializer in your application's config/initializers dir"

      def copy_initializer
        template 'api_authentication.rb', 'config/initializers/api_authentication.rb'
      end
    end
  end
end
