class AddColumnsToContributor < ActiveRecord::Migration
  def change
    add_column :contributors, :username, :string, null: false
    add_column :contributors, :email, :string, null: true
    add_column :contributors, :reputation, :integer, default: 0, null: false
    add_column :contributors, :blocked, :boolean, default: false, null: false
  end
end
