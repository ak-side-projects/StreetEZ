require 'spec_helper'

describe Photo do

  it { should validate_presence_of(:rental) }

  it { should belong_to(:rental) }

end
