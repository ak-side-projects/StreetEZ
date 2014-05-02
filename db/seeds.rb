require 'faker'
require_relative 'seed_photos'
require 'yelp_api'
include Timeout

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)

NUM_BEDROOMS = [1, 2, 3, 4]
NUM_BATHROOMS = [1, 2, 3, 4]

NEIGHBORHOODS_LIST = [
  "Chelsea",
  "Flatiron",
  "Gramercy",
  "West Village",
  "Greenwich Village",
  "Union Square",
  "East Village",
  "NoHo",
  "TriBeCa",
  "SoHo",
  "Lower East Side"
]

YELP_SESSION = YelpSession.new
YELP_JSON = YELP_SESSION.get_json_response

def generate_user!(num)
  puts "creating user: #{num}"
  user = User.new(
  email: "user#{num}@example.com", 
  name: Faker::Name.name, 
  password: "password",
  is_confirmed: true)
  user.save!
  
  10.times do |i|
    puts "creating rental: #{i}"
    generate_rental!(user)
  end
end

def generate_rental!(user)
  neighborhood = ""
  business = {}
  
  until NEIGHBORHOODS_LIST.include?(neighborhood)
    business = YELP_JSON['businesses'].sample
    neighborhood = business['location']['neighborhoods'].first
  end
  
  puts "neighborhood: #{neighborhood}"
  
  rental = user.owned_rentals.create!(
  num_bedrooms: NUM_BEDROOMS.sample,
  num_bathrooms: NUM_BATHROOMS.sample,
  sq_footage: rand(300..2500).round(-1),
  monthly_rent: rand(1000..10000).round(-2),
  neighborhood: neighborhood
  )
  
  Address.create!(
  street: business['location']['display_address'].first,
  unit: rand(1..30),
  city: business['location']['city'],
  state: business['location']['state_code'],
  zipcode: business['location']['postal_code'].to_i,
  rental_id: rental.id
  ) 
  
  #create photos
  urls = []
  urls << LIVING_ROOMS.sample
  urls << LIVING_ROOMS.sample
  urls << BEDROOMS.sample
  urls << BATHROOMS.sample
  
  urls.each do |url|
    begin
      Timeout::timeout(25){
        puts "working on this photo: #{url}"
        photo = rental.photos.new()
        photo.picture_from_url(url)
        photo.save!  
      }
    rescue
      puts "missed this photo: #{url}"
      retry
    end
  end
  
  #second living room photo for every other rental
  if rental.id % 2 == 0
    living_room_url_2 = LIVING_ROOMS.sample
    photo = rental.photos.new()
    photo.picture_from_url(living_room_url_2)
    photo.save!
  end
  
  # exterior for every other rental
  if rental.id % 2 == 0
    exterior_url = EXTERIOR.sample
    photo = rental.photos.new()
    photo.picture_from_url(exterior_url)
    photo.save!
  end
  
  return rental
end

num_users = (Rails.env.production? ? 15 : 3)
num_users.times do |i|
  generate_user!(i)
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

# Message.create!(sender_id: u1.id, recipient_id: u2.id, body: "message from user 1 to user 2")
# Message.create!(sender_id: u2.id, recipient_id: u1.id, body: "message from user 2 to user 1")
# Message.create!(sender_id: u1.id, recipient_id: u3.id, body: "message from user 1 to user 3")
# Message.create!(sender_id: u3.id, recipient_id: u1.id, body: "message from user 3 to user 1")