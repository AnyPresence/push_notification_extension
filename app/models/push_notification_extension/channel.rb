require 'gcm'
module PushNotificationExtension
  class Channel
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps

    # Channel identifier
    field :name, type: String

    attr_accessible :name

    has_and_belongs_to_many :devices, :class_name => "PushNotificationExtension::Device"
    
    has_many :messages, :class_name => "PushNotificationExtension::Message", :inverse_of => :channel

    def publish(badge = 0, alert, sound, message_payload)
      ios_notifications = []
      android_notifications = []
      android_device_tokens = []
      push_sound = sound.blank? ? "default" : sound
      
      ios_message_payload = nil
      if message_payload.is_a?(String)        
        begin
          ios_message_payload = JSON.parse(message_payload)
        rescue
          ios_message_payload = {data: message_payload}
        end
      end
      
      devices.each do |device|
        Rails.logger.info "Sending message #{message_payload}, with badge number #{badge}, to device #{device.token} of type #{device.type} for channel #{name}"
        ios_notifications << APNS::Notification.new(device.token, badge: badge, alert: alert, sound: push_sound, other: ios_message_payload) if device.ios?
        android_device_tokens << device.token if device.android?
      end
      
      if Rails.env.production?
        hashed_message_payload = Hash.new
        begin
          # Note that that app icons cannot be modified on the android side. This count will have to be displayed in 
          # a widget or from the notification system.
          hashed_message_payload["data"] = message_payload
          hashed_message_payload["badge"] = badge
        rescue
          Rails.logger.error "Unable to parse the message payload for android: " + $!.message
          Rails.logger.error $!.backtrace.join("\n")
        end  
        
        unless hashed_message_payload.nil?
          if AP::PushNotificationExtension::PushNotification.config[:gcm_api_key]
            gcm = ::GCM.new(AP::PushNotificationExtension::PushNotification.config[:gcm_api_key]) 
            gcm.send_notification(android_device_tokens, data: hashed_message_payload) if android_device_tokens
          end
        end
        
        APNS.send_notifications(ios_notifications) if !ios_notifications.blank?
        
        self.messages << Message.new(alert: alert, badge: badge, message_payload: message_payload)
      end
    end

  end
end
