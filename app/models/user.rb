class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :name, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true

  before_validation :ensure_session_token

  has_many(
    :owned_rentals,
    class_name: "Rental",
    foreign_key: :owner_id,
    inverse_of: :owner
  )

  has_many :addresses, through: :owned_rentals, source: :address

  has_many(
    :saves,
    class_name: "SavedRental",
    foreign_key: :user_id,
    inverse_of: :user
  )

  has_many :saved_rentals, through: :saves, source: :rental

  has_many(
    :sent_messages,
    class_name: "Message",
    foreign_key: :sender_id,
    inverse_of: :sender
  )

  has_many(
    :received_messages,
    class_name: "Message",
    foreign_key: :recipient_id,
    inverse_of: :recipient
  )
  
  has_many :notifications, inverse_of: :user, dependent: :destroy
  
  has_many :hosted_open_houses, through: :owned_rentals, source: :open_houses
  
  has_many :attend_open_houses, inverse_of: :user, dependent: :destroy
  
  has_many :open_houses, through: :attend_open_houses, source: :open_house


  def self.find_or_create_by_auth_hash(auth_hash)
    user = User.find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])

    return user if user

    User.create!(provider: auth_hash[:provider],
                 uid: auth_hash[:uid],
                 email: auth_hash[:info][:email],
                 name: auth_hash[:info][:name])
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    if password.present?
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
