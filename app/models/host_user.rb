class HostUser < ActiveRecord::Base
  has_secure_password
  has_many :forums
end
