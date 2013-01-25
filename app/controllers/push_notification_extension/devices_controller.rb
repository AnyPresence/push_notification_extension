require_dependency "push_notification_extension/application_controller"

module PushNotificationExtension
  class DevicesController < ApplicationController
    before_filter :authenticate_admin!
        
    def new
      @device = ::PushNotificationExtension::Device.new
    end
    
    def create
      @device = ::PushNotificationExtension::Device.new(params[:device])
      respond_to do |format|
        if @device.save
          format.html { redirect_to settings_url, notice: 'Successfully created.' }
        else
          format.html { render action: "new" }
        end
      end
    end
    
    def edit
      @device = ::PushNotificationExtension::Device.find(params[:id])
    end
    
    def update
      @device = ::PushNotificationExtension::Device.find(params[:id])

      respond_to do |format|
        if @device.update_attributes(params[:device])
          format.html { redirect_to settings_url, notice: 'Successfully created.' }
        else
          format.html { render action: "edit" }
        end
      end
    end
  end
end
