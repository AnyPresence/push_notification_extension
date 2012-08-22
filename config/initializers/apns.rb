APNS.host = 'gateway.push.apple.com' 

APNS.pem  = "#{Rails.root}/#{AP::PushNotificationExtension::PushNotification.config[:apple_cert]}"
APNS.pass = AP::PushNotificationExtension::PushNotification.config[:apple_cert_password] unless AP::PushNotificationExtension::PushNotification.config[:apple_cert_password].blank?

APNS.port = 2195