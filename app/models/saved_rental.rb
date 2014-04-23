class SavedRental < ActiveRecord::Base

  validates :user_id, :rental_id, presence: true

  belongs_to :user, inverse_of: :saves

  belongs_to :rental, inverse_of: :saves
  
  has_many :notifications, as: :notifiable
  
  after_commit :notify_saved_rental, on: :create
  
  after_commit :notify_unsaved_rental, on: :destroy
  
  def notify_saved_rental
    Notification.create(user_id: self.user_id, event_id: 3, notifiable_id: self.rental_id, notifiable_type: self.rental.class.name)
  end
  
  def notify_unsaved_rental
    Notification.create(user_id: self.user_id, event_id: 4, notifiable_id: self.rental_id, notifiable_type: self.rental.class.name)
  end
  
end
