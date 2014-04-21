class Address < ActiveRecord::Base

  validates(
    :neighborhood,
    :street,
    :unit,
    :city,
    :state,
    :zipcode,
    presence: true
  )

  validates :rental, presence: true

  belongs_to :rental, inverse_of: :address

end
