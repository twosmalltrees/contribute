class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :pending, :boolean, default: true
    add_column :comments, :removed, :boolean, default: false
    add_column :comments, :status, :string, default: "pending"
    add_column :comments, :is_reply, :boolean, default: false
    add_column :comments, :reply_to, :integer
    add_column :comments, :body_text, :text, null: false
  end
end
