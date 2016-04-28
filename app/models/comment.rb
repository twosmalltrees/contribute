class Comment < ActiveRecord::Base
  belongs_to :contributor
  belongs_to :forum
  has_many :flags
  has_many :reviews
end
