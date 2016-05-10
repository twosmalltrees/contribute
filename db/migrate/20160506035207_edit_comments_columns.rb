class EditCommentsColumns < ActiveRecord::Migration
  def change
    rename_column :comments, :forum_id, :discussion_id
  end
end
