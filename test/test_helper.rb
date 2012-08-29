# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

#require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require 'database_cleaner'

require 'push_notification_extension'

require 'factory_girl'

FactoryGirl.find_definitions

Rails.backtrace_cleaner.remove_silencers!

# Load support files
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
#if ActiveSupport::TestCase.method_defined?(:fixture_path=)
#  ActiveSupport::TestCase.fixture_path =  File.expand_path("../fixtures", __FILE__)
#end

#if ActionDispatch::IntegrationTest.method_defined?(:fixture_path=)
#  ActionDispatch::IntegrationTest.fixture_path =   File.expand_path("../fixtures", __FILE__)
#end

#if ActionController::TestCase.method_defined?(:fixture_path=)
# ActionController::TestCase.fixture_path =   File.expand_path("../fixtures", __FILE__)
#end

