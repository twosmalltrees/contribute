class Contributor < ActiveRecord::Base
  has_secure_password
  #
  has_many :comments
  has_many :flags
  has_many :reviews
  has_many :upvotes
  #
  validates :username, presence: true
  validates :password, length: { minimum: 6 }
  validates :reputation, presence: true
end
