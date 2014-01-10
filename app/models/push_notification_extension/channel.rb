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

    def publish(badge = 0, alert, sound, message_payload, pem_file_name = nil, pem_file_pass = nil)

      # Duplicate APNS Class and Change PEM on the fly
      apns_base = APNS.dup
      apns_base.pem = pem_file_name if !pem_file_name.blank?
      apns_base.pass = pem_file_pass if !pem_file_pass.blank?

      ios_notifications     = []
      android_notifications = []
      android_device_tokens = []
      
      ios_message_payload = nil
      if message_payload.is_a?(String)        
        begin
          ios_message_payload = JSON.parse(message_payload)
        rescue
          Rails.logger.info "Not able to parse message payload: #{$!.message}. Sending the payload as just {data: <message_payload>}."
          ios_message_payload = {data: message_payload}
        end
      else
        ios_message_payload = message_payload
      end
      
      devices.each do |device|
        Rails.logger.info "Sending message #{message_payload}, with badge number #{badge}, to device #{device.token} of type #{device.type} for channel #{name}"
        
        if device.ios?
          ios_notitifcation_options = {badge: badge, alert: alert, other: ios_message_payload}
          ios_notitifcation_options.merge!(sound: sound) if !sound.blank?
          ios_notifications << apns_base::Notification.new(device.token, ios_notitifcation_options)
        end
        
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
            if android_device_tokens
              gcm_result = gcm.send_notification(android_device_tokens, data: hashed_message_payload)
              Rails.logger.info "Channel #{self.name}: GCM push status: #{gcm_result}"
            else
              Rails.logger.info "Channel #{self.name}: There are no device tokens available for GCM."
            end
          end
        end
        
        ios_notifications.each do |ios_notification|
          apns_base.send_notifications([ios_notification])
        end
        
        self.messages << Message.new(alert: alert, badge: badge, message_payload: message_payload)
      else
        Rails.logger.info "Notifications will only be sent out for a production environment."
      end
    end

  end
end
