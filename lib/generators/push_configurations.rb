# Initializer to configure extensions
require "#{Rails.root.to_s}/config/initializers/redis"
require "#{Rails.root.to_s}/config/initializers/resque"

# Inactive extensions

# Active extensions
begin
  AP::PushNotificationExtension::PushNotification::config_account({"apple_cert"=>"config/apple_cert"})
rescue
  p "Unable to configure the extension: #{$!.message}"
  p $!.backtrace.join("\n")
end