module PushNotificationExtension
  module ChannelsHelper

    def shorten_device_token(token)
      if token.size > 20
        return "#{token.slice(0,20)}..."
      else
        return token
      end
    end
    
  end
end
