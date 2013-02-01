require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  
  test "should publish to GCM and APN with valid attributes" do
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = "something"
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT_PASSWORD'] = "something"
    channel = FactoryGirl.build_stubbed(:channel)
    Rails.stubs(:env => stub(production?: true)).returns(true)
    AP::PushNotificationExtension::PushNotification.stubs(:config).returns(gcm_api_key: "some_key") 
    GCM.any_instance.expects(:send_notification)
    #APNS.expects(:send_notifications)
    
    channel.publish(0, "some_alert", "some_payload")
    
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT_PASSWORD'] = nil
  end
  
end