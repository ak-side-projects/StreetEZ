class Notification < ActiveRecord::Base
    
  include Rails.application.routes.url_helpers  
  
  EVENTS = {
    1 => "received message",
    2 => "sent message",
    3 => "saved rental",
    4 => "unsaved rental",
    5 => "created open house",
    6 => "deleted open house",
    7 => "attend open house",
    8 => "unattend open house"
  }
  
  validates :notifiable_id, :notifiable_type, :user_id, :event_id, presence: true
  
  belongs_to :notifiable, polymorphic: true
  
  belongs_to :user, inverse_of: :notifications
  
  def get_url
    event = EVENTS[self.event_id]
    case event
    when "received message"
      message_path(self.notifiable)
    when "sent message"
      message_path(self.notifiable)
    when "saved rental"
      rental_path(self.notifiable)
    when "unsaved rental"
      rental_path(self.notifiable)
    when "attend open house"
      rental_path(self.notifiable.rental.id)
    when "unattend open house"
      rental_path(self.notifiable.rental.id)
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
    when "attend open house"
      street = self.notifiable.rental.address.street
      datetime = self.notifiable.event_datetime
      return "You signed up to attend the open house for #{street} on #{datetime}."
    when "unattend open house"
      street = self.notifiable.rental.address.street
      datetime = self.notifiable.event_datetime
      if self.notifiable.active
        return "You are no longer scheduled to attend the open house for #{street} on #{datetime}."
      else
        return "The open house at #{street} on #{datetime} that you were scheduled to attend has been cancelled."
      end
    end
  end
  
end
