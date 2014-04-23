require 'spec_helper'

describe Notification do
  
  it { should validate_presence_of(:notifiable_id) }
  it { should validate_presence_of(:notifiable_type) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:event_id) }
  
  it { should belong_to(:notifiable) }
  it { should belong_to(:user) }
  
  pending "test get_url"
  pending "test get_text"
  
end
