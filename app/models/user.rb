class User < ApplicationRecord
  has_secure_password
  has_many :listings

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true

  enum role: [:user, :admin]

  def self.destroy(id)
    return false if User.where(id: id) == []
    return true if User.find(id).destroy
  end

  
end
