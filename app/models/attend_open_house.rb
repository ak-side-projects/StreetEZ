class AttendOpenHouse < ActiveRecord::Base
  
  validates :open_house_id, :user_id, presence: true
  
  belongs_to :open_house, inverse_of: :attend_open_houses
  
  belongs_to :user, inverse_of: :attend_open_houses
  
end
