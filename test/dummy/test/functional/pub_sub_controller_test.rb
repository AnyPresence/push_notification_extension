require 'test_helper'

module PushNotificationExtension
  class PubSubControllerTest < ActionController::TestCase
    test "should be able to publish" do
      channel = FactoryGirl.create(:channel)
      device_ios = FactoryGirl.create(:device_ios)
      channel.devices << device_ios
      
      ::PushNotificationExtension::Channel.any_instance.expects(:publish).with("1", "1", "doh", "{\"data\":\"test\"}")
      post :publish, channel: channel.name, badge: "1", alert: "1", sound: "doh", message_payload: "{\"data\":\"test\"}", use_route: :push_notification_extension
      assert_response :success
    end
  end
end
