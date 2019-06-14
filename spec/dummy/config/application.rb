# frozen_string_literal: true

require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)

require 'api_authentication'

require 'draper'

module Dummy
  class Application < Rails::Application
    #
    # Add migrations from Engine
    #
    config.paths['db/migrate'] << '../../../db/migrate/'
  end
end
