APNS.host = 'gateway.push.apple.com' 

APNS.pem  = AP::PushNotificationExtension::PushNotification.config[:apple_cert]
APNS.pass = AP::PushNotificationExtension::PushNotification.config[:apple_cert_password]

APNS.port = 2195