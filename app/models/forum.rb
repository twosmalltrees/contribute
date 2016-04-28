class Forum < ActiveRecord::Base
  belongs_to :host_user
  has_many :comments
end
