class User < ActiveRecord::Base
  attr_reader :password

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
  
  validates :email, :name, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true
  
  after_commit :send_welcome_message, on: :create
    
  def self.find_by_auth_hash(auth_hash)
    User.find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
  end
  
  def self.create_by_auth_hash(auth_hash)
    User.create(provider: auth_hash[:provider],
                uid: auth_hash[:uid],
                email: auth_hash[:info][:email],
                name: auth_hash[:info][:name],
                password_digest: SecureRandom.urlsafe_base64(16)
               )
  end
  
  def update_with_auth_hash(auth_hash)
    self.update(provider: auth_hash[:provider], uid: auth_hash[:uid])
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
  
  def is_confirmed?
    self.is_confirmed
  end
  
  def send_welcome_message
    self.notifications.create(
    notifiable_id: self.id, 
    notifiable_type: self.class.name, 
    user_id: self.id, 
    event_id: 0)
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
