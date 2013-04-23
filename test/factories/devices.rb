FactoryGirl.define do
  factory :device_ios, :class => PushNotificationExtension::Device do
    token { Factory.next(:token) }
    type PushNotificationExtension::Device::IOS
  end
  
  factory :device_android, :class => PushNotificationExtension::Device do
    token { Factory.next(:token) }
    type PushNotificationExtension::Device::ANDROID
  end
end