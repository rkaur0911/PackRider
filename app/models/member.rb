class Member < ActiveRecord::Base
  has_secure_password

  validates_length_of :password, :minimum => 6, presence:true

  validates :password_digest, presence:true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :name, presence: true
end
