require_dependency "push_notification_extension/application_controller"

module PushNotificationExtension
  class ChannelsController < ApplicationController
    before_filter :authenticate_admin!
    
    def edit
      @channel = ::PushNotificationExtension::Channel.find(params[:id])
      @devices = @channel.devices.order_by([:type])
      @available_devices = ::PushNotificationExtension::Device.all.not_in(id: @devices.map {|d| d.id })
    end
    
    def new
      @channel = ::PushNotificationExtension::Channel.new
    end
    
    def create
      @channel = ::PushNotificationExtension::Channel.new(params[:channel])
      respond_to do |format|
        if @channel.save
          format.html { redirect_to settings_url, notice: 'Successfully created.' }
        else
          format.html { render action: "new" }
        end
      end
    end
    
    def update
      @channel = ::PushNotificationExtension::Channel.find(params[:id])
      devices_to_add = params[:device_ids]
      devices_to_add.each do |device|
        @channel.devices << ::PushNotificationExtension::Device.find(device)
      end
      
      @devices = @channel.devices.order_by([:type])
      @available_devices = ::PushNotificationExtension::Device.all.not_in(id: @devices.map {|d| d.id })
      respond_to do |format|
        format.html { render action: "edit" }
      end
    end
    
    def push
      @channel = ::PushNotificationExtension::Channel.find(params[:id])
      @messages = @channel.messages.order_by(:updated_at.desc).page(params[:page])
    end
    
    def manual_push
      @channel = ::PushNotificationExtension::Channel.find(params[:id])
      @channel.publish(params[:badge], params[:alert], params[:message])
      
      respond_to do |format|
        format.html { redirect_to settings_path }
      end
    end
    
  end
end
