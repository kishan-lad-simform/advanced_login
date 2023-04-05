class User < ApplicationRecord

  attr_accessor :remember_token
  
  validates :email, :username, uniqueness: true, presence: true
  validates :password, presence: true
  has_secure_password


  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    update_column(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column(:remember_digest, nil)
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
