class Rental < ActiveRecord::Base

  NEIGHBORHOODS = [
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

  NUM_BEDROOMS = [1, 2, 3, 4]

  NUM_BATHROOMS = [1, 2, 3, 4]
    
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
  
  has_many :open_houses, inverse_of: :rental, dependent: :destroy
  
  has_many :notifications, as: :notifiable
  
  scope :active, -> { where(active: true) }

  validates :neighborhood, inclusion: {in: NEIGHBORHOODS, message: "must be selected from the dropdown list"}

  validates_presence_of :num_bedrooms, message: ": Please select a number of bedrooms from the dropdown list"
  validates_presence_of :num_bathrooms, message: ": Please select a number of bathrooms from the dropdown list"
  
  validates(
    :sq_footage,
    :monthly_rent,
    presence: true
  )
  
  validates :address, associated: true

  validates :owner, presence: true
  
end
