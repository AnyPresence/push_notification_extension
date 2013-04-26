require 'test_helper'

module PushNotificationExtension
  class PubSubControllerTest < ActionController::TestCase
    
    setup do
      @channel = FactoryGirl.create(:channel)
      @device_ios = FactoryGirl.create(:device_ios)
      @channel.devices << @device_ios
    end
    
    test "should be able to publish" do
      ::PushNotificationExtension::Channel.any_instance.expects(:publish).with("1", "1", "doh", "{\"data\":\"test\"}")
      post :publish, channel: @channel.name, badge: "1", alert: "1", sound: "doh", message_payload: "{\"data\":\"test\"}", use_route: :push_notification_extension
      assert_response :success
    end
    
    test "should be able to subscribe" do
      request.stubs(:user_agent).returns('iPhone')
      post :subscribe, channel: @channel.name, device_token: "123", use_route: :push_notification_extension
      assert !::PushNotificationExtension::Channel.where(name: @channel.name).first.devices.where(token: "123").empty?
      assert_response :success      
    end
        
    test "should be able to unsubscribe" do
      request.stubs(:user_agent).returns('iPhone')
      post :unsubscribe, channel: @channel.name, device_token: "123", use_route: :push_notification_extension
      assert ::PushNotificationExtension::Channel.where(name: @channel.name).first.devices.where(token: "123").empty?
      assert_response :success      
    end
  end
end
