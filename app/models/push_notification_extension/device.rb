module PushNotificationExtension
  class Device
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps

    IOS = "ios"
    ANDROID = "android"
    TYPES = [IOS, ANDROID]

    # Unique device token.
    field :token, type: String

    # Device type, currently only iOS or Android.
    field :type, type: String

    validates :token, presence: true, uniqueness: { scope: :type }, format: { without: /null/ }
    validates :type, presence: true, inclusion: { in: TYPES }

    before_create :scrub_token

    attr_accessible :token, :type

    has_and_belongs_to_many :channels, :class_name => "PushNotificationExtension::Channel"

    def ios?
      type.eql? IOS
    end

    def android?
      type.eql? ANDROID
    end
private

  def scrub_token
    self.token = token.sub(/\s|<|>/,'')
  end

  end
end
