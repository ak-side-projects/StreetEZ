class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true
  validates :session_token, presence: true

  before_validation :ensure_session_token

  has_many(
    :owned_rentals,
    class_name: "Rental",
    foreign_key: :owner_id,
    inverse_of: :owner
  )

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
