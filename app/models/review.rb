class Review < ActiveRecord::Base
  belongs_to :comment
  belongs_to :contributor
end
