class Contributor < ActiveRecord::Base
  has_many :comments
  has_many :flags
  has_many :reviews
end
