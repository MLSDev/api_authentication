# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
require 'rspec/rails'
require 'rspec/its'
require 'shoulda-matchers'
require 'shoulda-callback-matchers'
require 'ffaker'
require 'factory_bot_rails'
require 'database_cleaner'

Dir['./spec/support/**/*.rb'].each(&method(:require))

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.mock_with :rspec
  config.order = :random
  config.color = true
  config.tty = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ApiAuthentication::Engine.routes.url_helpers
  config.include Requests::JsonHelpers, type: :request
  config.include RequestAuthentication, type: :request
end

ActiveJob::Base.queue_adapter = :test
ActiveRecord::Base.observers.disable :all if ActiveRecord::Base.respond_to? :observers
