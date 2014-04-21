class Rental < ActiveRecord::Base

  validates(
    :num_bedrooms,
    :num_bathrooms,
    :sq_footage,
    :monthly_rent,
    presence: true
  )

  validates :owner, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    inverse_of: :owned_rentals
  )

end
