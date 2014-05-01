# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)

num_bedrooms = ["Studio", 1, 2, 3, 4]

num_bathrooms = [1, 2, 3, 4]

neighborhoods = [
  "Chelsea",
  "Flatiron",
  "Gramercy",
  "West Village",
  "Greenwich Village",
  "Union Square",
  "East Village",
  "Noho",
  "Tribeca",
  "Soho",
  "Lower East Side"
]

yelp_session = YelpSession.new
yelp_json = yelp_session.get_json_response

def generate_user(num)
  user = User.new(
  email: "user#{num}@example.com", 
  name: Faker::Name.name, 
  password: "password")
  user.save!
  
  10.times { generate_rental(user.id) }
end

def generate_rental(user_id)
  neighborhood = ""
  business = {}
  until neighborhoods.include?(neighborhood)
    business = yelp_json['busineses'].sample
    neighborhood = business['location']['neighborhoods'].first
  end
  
  rental = Rental.create!(
  num_bedrooms: num_bedrooms.sample,
  num_bathrooms: num_bathrooms.sample,
  sq_footage: rand(300..2000),
  monthly_rent: rand(1000..10000),
  owner_id: user_id,
  neighborhood: neighborhood
  )
  
  address = rental.address.create!(
  street: business['location']['display_address'].first
  unit: rand(1..30)
  city: business['location']['city']
  state: business['location']['state_code']
  zipcode: business['location']['postal_code'].to_i
  ) 
  
  #living room photo
  living_room_url = LIVING_ROOMS.sample
  photo = rental.photos.new()
  photo.picture_from_url(living_room_url)
  photo.save!
  
  #second living room photo for every other rental
  if rental.id % 2 == 0
    living_room_url_2 = LIVING_ROOMS.sample
    photo = rental.photos.new()
    photo.picture_from_url(living_room_url_2)
    photo.save!
  end
  
  #kitchen photo
  kitchen_url = LIVING_ROOMS.sample
  photo = rental.photos.new()
  photo.picture_from_url(kitchen_url)
  photo.save!

  
  #bedroom photo
  bedroom_url = BEDROOMS.sample
  photo = rental.photos.new()
  photo.picture_from_url(bedroom_url)
  photo.save!

  
  #bathroom photo
  bathroom_url = BATHROOMS.sample
  photo = rental.photos.new()
  photo.picture_from_url(bathroom_url)
  photo.save!

  
  # exterior for every other rental
  if rental.id % 2 == 0
    exterior_url = EXTERIOR.sample
    photo = rental.photos.new()
    photo.picture_from_url(exterior_url)
    photo.save!
  end
end


num_users = (Rails.env.production? ? 25 : 5)

num_users.times do |i|
  generate_user(i)
end








# u1 = User.create!(email: "user1@example.com", name: "User1", password: "123456")
# u2 = User.create!(email: "user2@example.com", name: "User2", password: "123456")
# u3 = User.create!(email: "user3@example.com", name: "User3", password: "123456")
# u4 = User.create!(email: "user4@example.com", name: "User4", password: "123456")
# 
# r1 = Rental.create!(num_bedrooms: 1, num_bathrooms: 1, sq_footage: 500, monthly_rent: 1500, neighborhood: "West Village", owner_id: u1.id)
# r2 = Rental.create!(num_bedrooms: 1, num_bathrooms: 1, sq_footage: 800, monthly_rent: 2000, neighborhood: "West Village", owner_id: u1.id)
# r3 = Rental.create!(num_bedrooms: 2, num_bathrooms: 1, sq_footage: 900, monthly_rent: 3000, neighborhood: "East Village", owner_id: u1.id)
# r4 = Rental.create!(num_bedrooms: 2, num_bathrooms: 2, sq_footage: 1200, monthly_rent: 4200, neighborhood: "East Village", owner_id: u2.id)
# r5 = Rental.create!(num_bedrooms: 3, num_bathrooms: 1, sq_footage: 1500, monthly_rent: 5000, neighborhood: "Tribeca", owner_id: u2.id)
# r6 = Rental.create!(num_bedrooms: 3, num_bathrooms: 2, sq_footage: 2000, monthly_rent: 6000, neighborhood: "Tribeca", owner_id: u3.id)
# 
# Address.create!(rental_id: r1.id, street: "100 Jane St", unit: "1W", city: "New York", state: "NY", zipcode: 10014)
# Address.create!(rental_id: r2.id, street: "100 Jane St", unit: "2W", city: "New York", state: "NY", zipcode: 10014)
# Address.create!(rental_id: r3.id, street: "808 Broadway", unit: "3E", city: "New York", state: "NY", zipcode: 10003)
# Address.create!(rental_id: r4.id, street: "808 Broadway", unit: "4E", city: "New York", state: "NY", zipcode: 10003)
# Address.create!(rental_id: r5.id, street: "73 Worth St", unit: "5", city: "New York", state: "NY", zipcode: 10013)
# Address.create!(rental_id: r6.id, street: "73 Worth St", unit: "6", city: "New York", state: "NY", zipcode: 10013)
# 
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '1.jpg')), rental_id: r1.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '2.jpg')), rental_id: r1.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '3.jpg')), rental_id: r1.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '4.jpg')), rental_id: r1.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '5.jpg')), rental_id: r2.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '6.jpg')), rental_id: r2.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '7.jpg')), rental_id: r2.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '8.jpg')), rental_id: r2.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '9.jpg')), rental_id: r3.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '10.jpg')), rental_id: r3.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '11.jpg')), rental_id: r3.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '12.jpg')), rental_id: r3.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '13.jpg')), rental_id: r4.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '14.jpg')), rental_id: r4.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '15.jpg')), rental_id: r4.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '16.jpg')), rental_id: r4.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '17.jpg')), rental_id: r5.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '18.jpg')), rental_id: r5.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '19.jpg')), rental_id: r5.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '20.jpg')), rental_id: r5.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '21.jpg')), rental_id: r6.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '22.jpg')), rental_id: r6.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '23.jpg')), rental_id: r6.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '24.jpg')), rental_id: r6.id)
# Photo.create!(file: File.open(Rails.root.join('public', 'seed_photos', '25.jpg')), rental_id: r6.id)

Message.create!(sender_id: u1.id, recipient_id: u2.id, body: "message from user 1 to user 2")
Message.create!(sender_id: u2.id, recipient_id: u1.id, body: "message from user 2 to user 1")
Message.create!(sender_id: u1.id, recipient_id: u3.id, body: "message from user 1 to user 3")
Message.create!(sender_id: u3.id, recipient_id: u1.id, body: "message from user 3 to user 1")