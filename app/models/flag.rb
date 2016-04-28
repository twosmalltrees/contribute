class Flag < ActiveRecord::Base
  belongs_to :contributor
  belongs_to :comment
end
