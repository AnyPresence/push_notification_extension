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
  s.description =  <<-RUBY
    {
      "type": "ServiceInstance::RailsEngineGem",
      "name": "Push Notifications",
      "filename": "push_notification_extension",
      "version": "0.0.1",
      "description": "",
      "mount_name": "PushNotificationExtension::Engine",
      "mount_endpoint": "/push_notification_extension",
      "model_configuration": {
        "included_module": "AP::PushNotificationExtension::PushNotification",
        "fire_method": "execute_push_notification",
        "parameters": ["required_configuration"],
        "lifecyle_hooks": {
          "execute_push_notification": ["after_save", "after_create", "after_update", "after_destroy"]
        },
        "required_configuration": {
          "gcm_api_key": {
            "type": "String",
            "description": "API key for Android GCM."
          },
          "apple_cert": {
            "type": "File",
            "description": "Apple certificate for push notification servers."
          },
          "apple_cert_password": {
            "type": "String",
            "description": "Apple certificate password."
          }
        },
        "object_definition_level_configuration": {
          "channel": {
            "type": "String",
            "description": "Channel to publish message to."
          },
          "badge": {
            "type": "String",
            "description": "Value to set on the badge."
          },
          "alert": {
            "type": "String",
            "description": "Value display in an alert."
          },
          "message_payload": {
            "type": "String",
            "description": "JSON object containing extra information you would like to pass to the device."
          }
        }
      }
    }
RUBY

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "json"
  s.add_dependency "multi_json"
  s.add_dependency "gcm", "0.0.2"
  s.add_dependency "mongoid", ">= 2.4.12"
  s.add_dependency 'mongo', '<= 1.6.2' 
  s.add_dependency 'bson', '~> 1.6.4' 
  s.add_dependency 'bson_ext', '~> 1.6.4'
  s.add_dependency "liquid"

  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl", "= 3.3.0"
end
