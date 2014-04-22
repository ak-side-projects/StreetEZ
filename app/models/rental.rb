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

  NUM_BEDROOMS = ["Studio", 1, 2, 3, 4]

  NUM_BATHROOMS = [1, 2, 3, 4]

  validates(:neighborhood, inclusion: {in: NEIGHBORHOODS})

  validates(
    :num_bedrooms,
    :num_bathrooms,
    :sq_footage,
    :monthly_rent,
    :neighborhood,
    presence: true
  )

  validates :owner, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    inverse_of: :owned_rentals
  )

  has_one :address, inverse_of: :rental, dependent: :destroy

  has_many(
    :saves,
    class_name: "SavedRental",
    foreign_key: :rental_id,
    inverse_of: :rental
  )

  has_many :users, through: :saves, source: :user

  has_many :photos, inverse_of: :rental, dependent: :destroy

end
