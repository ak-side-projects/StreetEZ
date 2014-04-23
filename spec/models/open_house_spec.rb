require 'spec_helper'

describe OpenHouse do
  
  it { should validate_presence_of(:rental_id) }
  it { should validate_presence_of(:event_datetime) }
  
  it { should belong_to(:rental) }
  it { should have_one(:host) }
  it { should have_many(:attend_open_houses) }
  it { should have_many(:attendees) }
  
end
