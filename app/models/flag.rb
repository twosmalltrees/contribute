class Flag < ActiveRecord::Base
  belongs_to :contributor
  belongs_to :comment

  validates :contributor_id, presence: true
  validates :comment_id, presence: true
  
end
