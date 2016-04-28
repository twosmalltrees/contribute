class Contributor < ActiveRecord::Base
  has_secure_password
  has_many :comments
  has_many :flags
  has_many :reviews
end
