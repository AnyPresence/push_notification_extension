$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "push_notification_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "push_notification_extension"
  s.version     = PushNotificationExtension::VERSION
  s.authors     = ["Anypresence"]
  s.email       = ["jbozek@anypresence.com"]
  s.homepage    = "http://www.anypresence.com"
  s.summary     = "The most awesome push notification engine in the world. THE WORLD."
  s.description = "Push notification integration for apps generated using AnyPresence's solution."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"] + ["manifest.json"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "json"
  s.add_dependency "multi_json"
  s.add_dependency "gcm", "~> 0.0.2"
  s.add_dependency "mongoid", "~> 3.0.6"
  s.add_dependency "liquid"
  s.add_dependency "simple_form"
  s.add_dependency "kaminari", '~> 0.14.1'

  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl", "= 3.3.0"
  s.add_development_dependency "debugger", '1.5.0'
end
