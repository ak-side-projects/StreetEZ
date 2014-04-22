require 'spec_helper'

describe Rental do

  it { should validate_presence_of(:num_bedrooms) }
  it { should validate_presence_of(:num_bathrooms) }
  it { should validate_presence_of(:sq_footage) }
  it { should validate_presence_of(:monthly_rent) }
  it { should validate_presence_of(:neighborhood) }
  it { should validate_presence_of(:owner) }

  it { should ensure_inclusion_of(:neighborhood).in_array(Rental::NEIGHBORHOODS) }

  it { should belong_to(:owner) }
  it { should have_one(:address) }
  it { should have_many(:saves) }
  it { should have_many(:users) }
end