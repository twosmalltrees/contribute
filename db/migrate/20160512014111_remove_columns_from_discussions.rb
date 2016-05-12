class RemoveColumnsFromDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :unique_identifier
  end
end
