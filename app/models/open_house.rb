class OpenHouse < ActiveRecord::Base
    
  scope :active, -> { where(active: true) }
  
  validates :rental_id, presence: true
  validates :event_datetime, presence: { message: "Please fill out the date and time in the appropriate fields."}
  
  belongs_to :rental, inverse_of: :open_houses
  
  has_one :host, through: :rental, source: :owner
  
  has_many :attend_open_houses, inverse_of: :open_house, dependent: :destroy
  
  has_many :attendees, through: :attend_open_houses, source: :user
  
  has_many :notifications, as: :notifiable
  
end
