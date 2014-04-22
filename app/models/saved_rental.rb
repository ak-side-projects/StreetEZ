class SavedRental < ActiveRecord::Base

  validates :user_id, :rental_id, presence: true

  belongs_to :user, inverse_of: :saves

  belongs_to :rental, inverse_of: :saves

end
