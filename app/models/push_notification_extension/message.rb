module PushNotificationExtension
  class Message
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps
    
    paginates_per 10
    
    attr_accessible :alert, :badge, :message_payload
    
    field :alert, type: String
    field :badge, type: String
    field :message_payload, type: String
    
    belongs_to :channel, class_name: "PushNotificationExtension::Channel", inverse_of: :channel
    
  end
end
