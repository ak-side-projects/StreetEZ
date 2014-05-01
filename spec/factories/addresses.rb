# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street { |street| Faker::Address.street_address }
    city { |city| Faker::Address.city }
    state { |state| Faker::Address.state_abbr }
    zipcode { |zipcode| Faker::Address.zip_code }
  end
end
