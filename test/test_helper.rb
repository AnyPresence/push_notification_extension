# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment", __FILE__)
#require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require 'database_cleaner'
require 'push_notification_extension'

require 'factory_girl'

FactoryGirl.find_definitions

Rails.backtrace_cleaner.remove_silencers!

# Load support files
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../../test/fixtures", __FILE__)
end
