# frozen_string_literal: true

require 'rails/generators/named_base'

module ApiAuthentication
  module Generators
    class UserGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a ApiAuthentication initializer in your application's config/initializers dir"

      hook_for :orm
    end
  end
end
