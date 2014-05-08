class Address < ActiveRecord::Base

  belongs_to :rental, inverse_of: :address
  
  geocoded_by :full_street_address
  
  validates(
    :street,
    :unit,
    :city,
    :state,
    :zipcode,
    presence: true
  )

  validates :rental, presence: true
  
  after_validation :geocode
  
  def full_street_address
    [street, city, state, zipcode].compact.join(', ')
  end
  
end
