require 'spec_helper'

describe Address do

  it { should validate_presence_of(:neighborhood) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:unit) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zipcode) }

  it { should belong_to(:rental) }

end
