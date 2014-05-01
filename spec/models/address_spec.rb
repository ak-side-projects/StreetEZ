require 'spec_helper'

describe Address do

  subject(:address) do
    FactoryGirl.build(:address,
      street: "36 Cooper Sq",
      city: "New York",
      state: "NY",
      zipcode: "10003"
    )
  end
  
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:unit) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zipcode) }

  it { should belong_to(:rental) }
  
  it "creates a full street address string" do
    expect(address.full_street_address).to eq("36 Cooper Sq, New York, NY, 10003")
  end
  
end
