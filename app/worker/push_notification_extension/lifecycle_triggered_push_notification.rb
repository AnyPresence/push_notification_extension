class PushNotificationExtension::LifecycleTriggeredPushNotification
  @queue = :push_notification

  def self.perform(channel_identifier, badge = 0, message_payload = {})
    channel = ::PushNotificationExtension::Channel.where(name: channel_identifier).first || ::PushNotificationExtension::Channel.create(name: channel_identifier)
    channel.publish(badge, message_payload)
  end
end