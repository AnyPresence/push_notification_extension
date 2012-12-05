class CreatePushNotificationExtensionMessages < ActiveRecord::Migration
  def change
    create_table :push_notification_extension_messages do |t|

      t.timestamps
    end
  end
end
