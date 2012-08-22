module AP
  module PushNotificationExtension
    module PushNotification
      @@config = Hash.new
      def self.config_account(config={})
        if config.empty?
          raise "Nothing to configure!"
        end
        config = HashWithIndifferentAccess.new(config)
        @@config[:gcm_api_key] = config[:gcm_api_key]
        @@config[:apple_cert] = config[:apple_cert]
        @@config[:apple_cert_password] = config[:apple_cert_password]
        
        # This is for production apps/certs only.
        # APNS.host = 'gateway.push.apple.com' 

        APNS.pem  = "#{Rails.root}/#{::AP::PushNotificationExtension::PushNotification.config[:apple_cert]}"
        APNS.pass = ::AP::PushNotificationExtension::PushNotification.config[:apple_cert_password] unless ::AP::PushNotificationExtension::PushNotification.config[:apple_cert_password].blank?

        APNS.port = 2195
      end
      def self.config
        @@config
      end
      def execute_push_notification(object, options = {})
        options = HashWithIndifferentAccess.new(options)
        channel = ::PushNotificationExtension::Channel.where(name: options[:channel]).first || ::PushNotificationExtension::Channel.create(name: options[:channel])
        channel.publish(options[:badge], options[:alert], options[:message_payload])
      end
    end
  end
end