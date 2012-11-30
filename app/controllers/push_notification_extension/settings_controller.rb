require_dependency "push_notification_extension/application_controller"

module PushNotificationExtension
  class SettingsController < ApplicationController
    before_filter :authenticate_admin!

    def index
      @devices = ::PushNotificationExtension::Device.all.order_by([:type])
      @channels = ::PushNotificationExtension::Channel.all
    end
    
  end
end
