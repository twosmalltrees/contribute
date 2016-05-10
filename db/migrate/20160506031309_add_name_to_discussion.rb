class AddNameToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :name, :string
  end
end
