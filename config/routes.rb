PushNotificationExtension::Engine.routes.draw do
  post 'subscribe' => 'pub_sub#subscribe'
  post 'unsubscribe' => 'pub_sub#unsubscribe'
  post 'publish' => 'pub_sub#publish'
end
