require 'spec_helper'

describe AttendOpenHouse do
  
  it { should validate_presence_of(:open_house_id) }
  it { should validate_presence_of(:user_id) }
  
  it { should belong_to(:open_house) }
  it { should belong_to(:user) }
  
end
