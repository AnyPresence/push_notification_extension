require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  setup do
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = "something"
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT_PASSWORD'] = "something"
    @channel = FactoryGirl.create(:channel)
    Rails.stubs(:env => stub(production?: true)).returns(true)
  end
  
  test "should publish to GCM with valid attributes" do
    AP::PushNotificationExtension::PushNotification.stubs(:config).returns(gcm_api_key: "some_key") 
    GCM.any_instance.expects(:send_notification)
    
    @channel.publish(0, "some_alert", "default", "some_payload")
    
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT_PASSWORD'] = nil
  end
  
  test "should publish to APN with valid attributes" do
    message_payload = <<-TEXT
    {"data": "stuff"}
    TEXT

    device_ios = FactoryGirl.create(:device_ios)
    
    @channel.devices << device_ios

    APNS.expects(:send_notifications)
    @channel.publish(0, "some_alert", "default", message_payload)
  end
  
end