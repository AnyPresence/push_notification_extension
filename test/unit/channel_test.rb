require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  
  test "should publish to GCM and APN with valid attributes" do
    channel = FactoryGirl.build_stubbed(:channel)
    Rails.stubs(:env => stub(production?: true)).returns(true)
    AP::PushNotificationExtension::PushNotification.stubs(:config).returns(gcm_api_key: "some_key") 
    GCM.any_instance.expects(:send_notification)
    APNS.expects(:send_notifications)
    
    channel.publish(0, "some_alert", "some_payload")
  end
  
end