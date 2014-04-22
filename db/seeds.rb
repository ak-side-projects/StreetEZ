# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create(email: "user1@example.com", name: "User1", password: "123456")
User.create(email: "user2@example.com", name: "User2", password: "123456")
User.create(email: "user3@example.com", name: "User3", password: "123456")
User.create(email: "user4@example.com", name: "User4", password: "123456")

Rental.create(num_bedrooms: 1, num_bathrooms: 1, sq_footage: 500, monthly_rent: 1500, neighborhood: "West Village", owner_id: 1)
Rental.create(num_bedrooms: 1, num_bathrooms: 1, sq_footage: 800, monthly_rent: 2000, neighborhood: "West Village", owner_id: 1)
Rental.create(num_bedrooms: 2, num_bathrooms: 1, sq_footage: 900, monthly_rent: 3000, neighborhood: "East Village", owner_id: 1)
Rental.create(num_bedrooms: 2, num_bathrooms: 2, sq_footage: 1200, monthly_rent: 4200, neighborhood: "East Village", owner_id: 1)
Rental.create(num_bedrooms: 3, num_bathrooms: 1, sq_footage: 1500, monthly_rent: 5000, neighborhood: "Tribeca", owner_id: 1)
Rental.create(num_bedrooms: 3, num_bathrooms: 2, sq_footage: 2000, monthly_rent: 6000, neighborhood: "Tribeca", owner_id: 1)

Address.create(rental_id: 1, street: "100 Jane St", unit: "1W", city: "New York", state: "NY", zipcode: 10014)
Address.create(rental_id: 2, street: "100 Jane St", unit: "2W", city: "New York", state: "NY", zipcode: 10014)
Address.create(rental_id: 3, street: "808 Broadway", unit: "3E", city: "New York", state: "NY", zipcode: 10003)
Address.create(rental_id: 4, street: "808 Broadway", unit: "4E", city: "New York", state: "NY", zipcode: 10003)
Address.create(rental_id: 5, street: "73 Worth St", unit: "5", city: "New York", state: "NY", zipcode: 10013)
Address.create(rental_id: 6, street: "73 Worth St", unit: "6", city: "New York", state: "NY", zipcode: 10013)

Message.create(sender_id: 1, recipient_id: 2, body: "message from user 1 to user 2")
Message.create(sender_id: 2, recipient_id: 1, body: "message from user 2 to user 1")
Message.create(sender_id: 1, recipient_id: 3, body: "message from user 1 to user 3")
Message.create(sender_id: 3, recipient_id: 1, body: "message from user 3 to user 1")