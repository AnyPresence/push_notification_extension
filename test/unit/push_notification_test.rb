require 'test_helper'

class PushNotificationTest < ActiveSupport::TestCase

  test "should know how to setup from environment variables" do
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = "123"
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT'] = "345"
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT_PASSWORD'] = "password"

    AP::PushNotificationExtension::PushNotification.config_account

    assert_equal AP::PushNotificationExtension::PushNotification.config[:gcm_api_key], "123"
    assert_equal AP::PushNotificationExtension::PushNotification.config[:apple_cert], "345"
    assert_equal AP::PushNotificationExtension::PushNotification.config[:apple_cert_password], "password"
  end

  test "should raise error when there's no configuration" do
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = nil
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT'] = nil
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT_PASSWORD'] = nil

    assert_raise(RuntimeError) { AP::PushNotificationExtension::PushNotification.config_account }
  end

  test "should setup APN with valid attributes" do
    File.stubs(:file?).returns(true)
    file = stub(read: "something", close: "yay")
    File.stubs(:open).returns(file)
    ENV['AP_PUSH_NOTIFICATIONS_APPLE_CERT'] = nil
    AP::PushNotificationExtension::PushNotification.config_account(apple_cert: "tmp/cert")

    assert_equal "tmp/cert", AP::PushNotificationExtension::PushNotification.config[:apple_cert]
    assert_equal "#{Rails.root}/tmp/cert", APNS.pem
  end

  test "should setup GCM with valid attributes" do
    ENV['AP_PUSH_NOTIFICATIONS_GCM_API_KEY'] = nil
    AP::PushNotificationExtension::PushNotification.config_account(gcm_api_key: "some_key")
    assert_equal "some_key", AP::PushNotificationExtension::PushNotification.config[:gcm_api_key]
  end

end