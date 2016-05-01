class Contributor < ActiveRecord::Base
  has_secure_password

  has_many :comments
  has_many :flags
  has_many :reviews
  has_many :upvotes

  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :reputation, presence: true
  validates :blocked, presence: true
end
