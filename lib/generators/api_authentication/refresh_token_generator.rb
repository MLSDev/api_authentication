# frozen_string_literal: true

require 'rails/generators/named_base'

module ApiAuthentication
  module Generators
    class RefreshTokenGenerator < Rails::Generators::Base
      # include Rails::Generators::ResourceHelpers

      source_root File.expand_path('../templates', __FILE__)

      desc 'Creates a RefreshToken model and migration'

      hook_for :orm
    end
  end
end
