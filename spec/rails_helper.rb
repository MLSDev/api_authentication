ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'spec_helper'
require 'rspec/rails'
require 'rspec/its'
require 'shoulda-matchers'
require 'shoulda-callback-matchers'
require 'database_cleaner'
require 'ffaker'
require 'factory_bot_rails'

Dir['./spec/support/**/*.rb'].each(&method(:require))

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.mock_with :rspec
  config.order = :random
  config.color = true
  config.tty = true

  # config.include Authentication
  # config.include Permitter
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # config.before(:all) do
  #   FactoryBot.reload
  # end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

ActiveJob::Base.queue_adapter = :test

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

ActiveRecord::Base.observers.disable :all if ActiveRecord::Base.respond_to? :observers

# ActiveRecord::Base.connection.class.send(:define_method, :insert) { |*args| }

# ActiveRecord::Base.connection.class.send(:define_method, :update) { |*args| }

# ActiveRecord::Base.connection.class.send(:define_method, :delete) { |*args| }
