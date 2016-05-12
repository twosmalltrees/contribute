class AddDefaultValuesToCommentCols < ActiveRecord::Migration
  def change
    change_column :comments, :accepted_review_streak, :integer, :default => 0
    change_column :comments, :review_count, :integer, :default => 0
  end
end
