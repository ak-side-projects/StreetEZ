class OpenHouse < ActiveRecord::Base
  
  validates :rental_id, :event_date, :event_time, presence: true
  
  belongs_to :rental, inverse_of: :open_houses
  
  has_one :host, through: :rental, source: :owner
  
  has_many :attend_open_houses, inverse_of: :open_house
  
  has_many :attendees, through: :attend_open_houses, source: :user
  
end
