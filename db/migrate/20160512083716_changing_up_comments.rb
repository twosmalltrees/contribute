class ChangingUpComments < ActiveRecord::Migration
  def change
    add_column :comments, :accepted_review_streak, :integer
    add_column :comments, :review_count, :integer
    remove_column :comments, :pending
    remove_column :comments, :removed
    remove_column :comments, :is_reply
    remove_column :comments, :reply_to
  end
end
