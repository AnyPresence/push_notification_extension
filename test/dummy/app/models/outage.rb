class Outage
  include Mongoid::Document
  include Mongoid::Timestamps
  include AP::PushNotificationExtension::PushNotification
  
  # Field definitions
  
  field :"title", type: String
 
end
