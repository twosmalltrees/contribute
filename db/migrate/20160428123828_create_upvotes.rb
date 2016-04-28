class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :contributor_id, null: false
      t.integer :comment_id, null: false
      t.timestamps null: false
    end
  end
end
