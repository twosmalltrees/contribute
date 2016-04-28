class Comment < ActiveRecord::Base
  belongs_to :contributor
  belongs_to :forum
  has_many :flags
  has_many :reviews
  has_many :upvotes

  validates :contributor_id, presence: true
  validates :forum_id, presence: true
  validates :pending, presence: true
  validates :removed, presence: true
  validates :status, presence: true
  validates :is_reply, presence: true
  validates :body_text, presence: true, length: { minimum: 5 }
end
