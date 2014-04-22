require 'spec_helper'

describe SavedRental do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:rental_id) }

  it { should belong_to(:user) }
  it { should belong_to(:rental) }

end
