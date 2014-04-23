class AttendOpenHouse < ActiveRecord::Base
  
  validates :open_house_id, :user_id, presence: true
  
  belongs_to :open_house, inverse_of: :attend_open_houses
  
  belongs_to :user, inverse_of: :attend_open_houses
   
  has_many :notifications, as: :notifiable
  
  after_commit :notify_attend_open_house, on: :create
  
  after_commit :notify_unattend_open_house, on: :destroy
  
  def notify_attend_open_house
    Notification.create(
      user_id: self.user_id, event_id: 7, 
      notifiable_id: self.open_house.id, notifiable_type: self.open_house.class.name
    )
      
    # Notification.create(
    #   user_id: self.open_house.host.id, event_id: 8, 
    #   notifiable_id: self.id, notifiable_type: self.class.name
    # )
  end
  
  def notify_unattend_open_house
    Notification.create(
      user_id: self.user_id, event_id: 9, 
      notifiable_id: self.open_house.id, notifiable_type: self.open_house.class.name
    )
  
    # if self.open_house.active
    #   Notification.create(
    #     user_id: self.open_house.host.id, event_id: 10, 
    #     notifiable_id: self.id, notifiable_type: self.class.name
    #   )
    # end
  end
   
end
