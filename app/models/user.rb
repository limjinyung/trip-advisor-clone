class User < ApplicationRecord
  has_secure_password
  has_many :listings

  enum role: [:user, :admin]

  validates :email, presence: true, uniqueness: true
end
