class Notification < ActiveRecord::Base
  
  EVENTS = {
    1 => "received message",
    2 => "sent message"
  }
  
  validates :notifiable_id, :notifiable_type, :user_id, :event_id, presence: true
  
  belongs_to :notifiable, polymorphic: true
  
  belongs_to :user, inverse_of: :notifications
  
  def get_url
    self.notifiable_type.pluralize.downcase + "/" + notifiable_id.to_s
  end
  
  def get_text
    event = EVENTS[self.event_id]
    case event
    when "received message"
      return "You received a message from " + self.notifiable.sender.name + "."
    when "sent message"
      return "You sent a message to " + self.notifiable.recipient.name + "."
    end
  end
  
end
