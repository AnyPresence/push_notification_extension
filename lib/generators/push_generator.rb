class PushNotificationExtensionRailtie < Rails::Generators::Base
  source_root(File.expand_path(File.dirname(__FILE__)))
  def copy_initializer
    copy_file 'push_configurations.rb', 'config/initializers/push_configurations.rb'
  end
end