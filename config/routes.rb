PushNotificationExtension::Engine.routes.draw do
  post 'subscribe' => 'pub_sub#subscribe'
  post 'unsubscribe' => 'pub_sub#unsubscribe'
  post 'publish' => 'pub_sub#publish'
  
  resources :channels do
  end
  
  root :to => "settings#index"
end
