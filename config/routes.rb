PushNotificationExtension::Engine.routes.draw do
  post 'subscribe' => 'pub_sub#subscribe'
  post 'unsubscribe' => 'pub_sub#unsubscribe'
  post 'publish' => 'pub_sub#publish'
  get 'settings' => 'settings#index'
  
  resources :channels do
    member do
      get 'push'
      put 'manual_push'
    end
  end
  
  root :to => "settings#index"
end
