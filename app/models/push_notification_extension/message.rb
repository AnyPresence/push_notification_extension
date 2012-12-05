module PushNotificationExtension
  class Message
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps
    
    attr_accessible :alert, :badge, :message_payload
    
    field :alert, type: String
    field :badge, type: String
    field :message_payload, type: String
    
    has_and_belongs_to_many :channels, :class_name => "PushNotificationExtension::Message"
    
  end
end
