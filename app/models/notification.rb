class Notification < ActiveRecord::Base
    
  include Rails.application.routes.url_helpers  
  
  EVENTS = {
    1 => "received message",
    2 => "sent message",
    3 => "saved rental",
    4 => "unsaved rental"
  }
  
  validates :notifiable_id, :notifiable_type, :user_id, :event_id, presence: true
  
  belongs_to :notifiable, polymorphic: true
  
  belongs_to :user, inverse_of: :notifications
  
  def get_url
    event = EVENTS[self.event_id]
    case event
    when "received message"
      self.notifiable_type.pluralize.downcase + "/" + notifiable_id.to_s
    when "sent message"
      self.notifiable_type.pluralize.downcase + "/" + notifiable_id.to_s
    when "saved rental"
      "rentals/" + self.notifiable.id.to_s
    when "unsaved rental"
      "rentals/" + self.notifiable.id.to_s
    end
  end
  
  def get_text
    event = EVENTS[self.event_id]
    case event
    when "received message"
      return "You received a message from " + self.notifiable.sender.name + "."
    when "sent message"
      return "You sent a message to " + self.notifiable.recipient.name + "."
    when "saved rental"
      return "You saved " + self.notifiable.address.street + " to your profile."
    when "unsaved rental"
      return "You removed " + self.notifiable.address.street + " from your profile."
    end
  end
  
end
