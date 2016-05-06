class AddColumnsToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :forum_id, :string, null: false
    add_column :discussions, :page_url, :string
    add_column :discussions, :unique_identifier, :string, null: false
  end
end
