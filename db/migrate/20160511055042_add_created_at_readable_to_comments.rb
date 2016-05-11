class AddCreatedAtReadableToComments < ActiveRecord::Migration
  def change
    add_column :comments, :created_at_readable, :string
  end
end
