AnyPresence Push Notifications Extension.
=========
Modified to push to multiple applications

## Installation
Add the following to your Gemfile:

`gem 'push_notification_extension', git: 'git://github.com/DavidBenko/push_notification_extension.git'`

Then run

`bundle install`

### Resque
This extension uses resque. 

Start it with:

`bundle exec rake resque:work QUEUE=*`

## How to use
```ruby
# Example Code
# app_id is some application-specific identifier
def send_push_notification(app_id)
  # Set paths to pem files
  push_certs = HashWithIndifferentAccess.new({:push_one => 'config/push_one.pem', :push_two => 'config/push_two.pem'})
  push_cert_passwords = HashWithIndifferentAccess.new({:push_one => 'password1', :push_two => 'password2'})
  
  # Set gcm Key
  gcm_key = 'gcm_key_here'
  
  # Configure push notifications for specific broadcast
  config = {:apple_cert => push_certs[app_id], :apple_cert_password => push_cert_passwords[app_id], :gcm_api_key => gcm_key}
  
  # Find * application-specific * channel
  # (If this is not application-specific, all android devices will receieve the notification, regardless of app)
  channel = ::PushNotificationExtension::Channel.where(name: "global_channel_#{app_id}").first
  
  # Publish and pass in config
  channel.publish(1,'Object Created', 'default', HashWithIndifferentAccess.new({:app_id => app_id}),config)
end
```
