require 'spec_helper'

describe Message do

  it { should validate_presence_of(:sender_id) }
  it { should validate_presence_of(:recipient_id) }
  it { should validate_presence_of(:body) }

  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }

end
