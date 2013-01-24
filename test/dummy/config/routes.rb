Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do  
      resources :outages
    end
    mount PushNotificationExtension::Engine => "/push_notification_extension"
  end
 
end
