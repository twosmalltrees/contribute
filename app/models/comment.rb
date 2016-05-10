class Comment < ActiveRecord::Base
  scope :under_review, -> { where( status: "pending" ) }

  belongs_to :contributor
  belongs_to :discussion
  has_many :flags
  has_many :reviews
  has_many :upvotes

  validates :contributor_id, presence: true
  validates :discussion_id, presence: true
  validates :body_text, presence: true, length: { minimum: 5 }
end
