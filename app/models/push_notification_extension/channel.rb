module PushNotificationExtension
  class Channel
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps

    # Channel identifier
    field :name, type: String

    attr_accessible :name

    has_and_belongs_to_many :devices, :class_name => "PushNotificationExtension::Device"

    def publish(badge = 0, alert, message_payload)
      ios_notifications = []
      android_notifications = []
      android_device_tokens = []
      devices.each do |device|
        Rails.logger.info "Sending message #{message_payload}, with badge number #{badge}, to device #{device.token} of type #{device.type} for channel #{name}"
        ios_notifications << APNS::Notification.new(device.token, badge: badge, alert: alert, other: message_payload) if device.ios?
        android_device_tokens << device.token if device.android?
      end
      if Rails.env.production?
        hashed_message_payload = nil
        begin
          # Note that that app icons cannot be modified on the android side. This count will have to be displayed in 
          # a widget or from the notification system.
          json_rep = "{\"data\":\"#{message_payload}\",\"badge\":#{badge}}"
          json_rep = JSON.parse(json_rep).to_json
          hashed_message_payload = ActiveSupport::JSON.decode(json_rep)
        rescue
          Rails.logger.error "Unable to parse the message payload for android: " + $!.message
          Rails.logger.error $!.backtrace.join("\n")
        end  
        
        unless hashed_message_payload.nil?
          gcm = GCM.new(AP::PushNotificationExtension::PushNotification.config[:gcm_api_key]) if AP::PushNotificationExtension::PushNotification.config[:gcm_api_key]
          gcm.send_notification(android_device_tokens, data: hashed_message_payload) if android_device_tokens
        end
        
        APNS.send_notifications(ios_notifications) if ios_notifications
      end
    end

  end
end
