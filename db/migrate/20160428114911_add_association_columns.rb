class AddAssociationColumns < ActiveRecord::Migration
  def change
    add_column :comments, :contributor_id, :integer
    add_column :comments, :forum_id, :integer
    add_column :flags, :comment_id, :integer
    add_column :flags, :contributor_id, :integer
    add_column :reviews, :comment_id, :integer
    add_column :reviews, :contributor_id, :integer
    add_column :forums, :host_user_id, :integer
  end
end
