class AddColumnsToForums < ActiveRecord::Migration
  def change
    add_column :forums, :root_domain, :string, null: false
    add_column :forums, :forum_shortname, :string, null: false
  end
end
