Rails.application.routes.draw do

  resources :outages

  mount PushNotificationExtension::Engine => "/push_notification_extension"
end
