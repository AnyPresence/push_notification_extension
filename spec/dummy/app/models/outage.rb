class Outage
  include Mongoid::Document
  include Mongoid::Timestamps
  include AP::PushNotificationExtension::PushNotification
  
  # Field definitions
  
  field :"_id", as: :id, type: String
     
  def save
    super
  end
  
end
