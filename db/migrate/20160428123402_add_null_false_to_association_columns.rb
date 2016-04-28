class AddNullFalseToAssociationColumns < ActiveRecord::Migration
  def change
    change_column :comments, :contributor_id, :integer, null: false
    change_column :comments, :forum_id, :integer, null: false
    change_column :flags, :comment_id, :integer, null: false
    change_column :flags, :contributor_id, :integer, null: false
    change_column :reviews, :comment_id, :integer, null: false
    change_column :reviews, :contributor_id, :integer, null: false
    change_column :forums, :host_user_id, :integer, null: false
  end
end
