class Message < ActiveRecord::Base

  validates :sender_id, :recipient_id, :body, presence: true

  belongs_to(
    :sender,
    class_name: "User",
    foreign_key: :sender_id,
    inverse_of: :sent_messages
  )

  belongs_to(
    :recipient,
    class_name: "User",
    foreign_key: :recipient_id,
    inverse_of: :received_messages
  )
  
  has_many :notifications, as: :notifiable
  
  after_commit :notify_users, on: [:create]
  
  def notify_users
    recipient = self.recipient
    sender = self.sender
    
    self.notifications.create(user_id: recipient.id, event_id: 1)
    
    self.notifications.create(user_id: sender.id, event_id: 2)
  end

end
