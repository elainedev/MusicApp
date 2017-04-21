class User < ApplicationRecord

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true
  # above validation validates password method from the attr_reader password

  after_initialize :ensure_session_token #after_initialize occurs after callling User.new and before calling below methods

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token  # only modified the user object, did not save object to user database
    self.save!  # don't forget to save to database
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  attr_reader :password

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password #store in instance variable for validation
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
    #password_digest is Active Record's way of retrieving column password_digest
    #BCrypt::Password.new takes hashed password_diogest, create takes password string
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email) # options hash
    return user if user && user.is_password?(password)
    nil
  end




end
