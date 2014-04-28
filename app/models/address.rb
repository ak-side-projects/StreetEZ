class Address < ActiveRecord::Base

  validates(
    :street,
    :unit,
    :city,
    :state,
    :zipcode,
    presence: true
  )

  validates :rental, presence: true

  belongs_to :rental, inverse_of: :address
  
  geocoded_by :full_street_address
  
  after_validation :geocode
  
  def full_street_address
    [street, city, state, zipcode].compact.join(', ')
  end
  
end
