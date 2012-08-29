require 'test_helper'

class PushNotificationTest < ActiveSupport::TestCase
  
  test "should raise exception with empty config" do
    assert_raise(RuntimeError) { AP::PushNotificationExtension::PushNotification.config_account({}) }
  end
  
  test "should setup APN with valid attributes" do
    File.stubs(:file?).returns(true)
    file = stub(read: "something", close: "yay")
    File.stubs(:open).returns(file)
    AP::PushNotificationExtension::PushNotification.config_account(apple_cert: "tmp/cert")
    
    assert_equal "tmp/cert", AP::PushNotificationExtension::PushNotification.config[:apple_cert]
    assert_equal "#{Rails.root}/tmp/cert", APNS.pem
  end
  
  test "should setup GCM with valid attributes" do 
    AP::PushNotificationExtension::PushNotification.config_account(gcm_api_key: "some_key")
    assert_equal "some_key", AP::PushNotificationExtension::PushNotification.config[:gcm_api_key]
  end
  
end