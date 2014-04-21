class Rental < ActiveRecord::Base

  NEIGHBORHOODS = [
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

  validates(:neighborhood, inclusion: {in: NEIGHBORHOODS})

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

  has_one :address, inverse_of: :rental

end
