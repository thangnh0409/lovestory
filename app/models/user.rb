class User < ActiveRecord::Base
  validates :name, presence: true, length:{maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  attr_accessor :remember_token
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : Bcrypt::Engine.cost
    Bcrypt::Password.create(string,  cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,  User.digeset(remember_token))
  end

  def forget
    update_attribute(:remember_digest,  nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
