require_dependency "push_notification_extension/application_controller"

module PushNotificationExtension
  class PubSubController < ApplicationController
    before_filter :detect_mobile_os, only: [ :subscribe, :unsubscribe ]
    protect_from_forgery :except => [:subscribe, :unsubscribe, :publish]

    def subscribe
      device = ::PushNotificationExtension::Device.where(token: ::PushNotificationExtension::Device.scrub_token(params[:device_token]), type: @device_type).first || ::PushNotificationExtension::Device.create(token: params[:device_token], type: @device_type)
      Rails.logger.info "Received subscription request from mobile device: " + device.inspect
      if device.persisted?
        channel = ::PushNotificationExtension::Channel.where(name: params[:channel]).first || ::PushNotificationExtension::Channel.create(name: params[:channel])
        channel.devices << device
        if channel.save
          render :json => { :success => true }
        else
          render :json => { :success => false, :error => channel.errors }
        end
      else
        render :json => { :success => false, :error => device.errors }
      end
    end

    def unsubscribe
      device = ::PushNotificationExtension::Device.where(token: params[:device_token], type: @device_type).first
      if device
        Rails.logger.info "Received unsubscribe request from mobile device: " + device.inspect
        channel = ::PushNotificationExtension::Channel.where(name: params[:channel]).first
        if channel
          begin
            channel.devices.delete device
            device.channels.delete channel
            render :json => { :success => true }
          rescue
            render :json => { :success => false, :error => $!.message }
          end
        else
          render :json => { :success => false, :error => "invalid channel" }
        end
      else
        render :json => { :success => false, :error => "invalid device" }
      end
    end

    def publish
      channel = ::PushNotificationExtension::Channel.where(name: params[:channel]).first
      if channel
        begin
          channel.publish(params[:badge], params[:alert], params[:sound], params[:message_payload])
          render :json => { :success => true }
        rescue
          render :json => { :success => false, :error => $!.message }
        end
      else
        render :json => { :success => false, :error => "invalid channel" }
      end
    end

    protected

      def detect_mobile_os
        if ios?
          @device_type = "ios"
        elsif android?
          @device_type = "android"
        else
          render :json => { :success => false, :error => 'invalid device type' }
        end
      end

      def ios?
        request.user_agent =~ /iPhone|iPad|iPod/i
      end

      def android?
        request.user_agent =~ /Android/i
      end
  end
end
