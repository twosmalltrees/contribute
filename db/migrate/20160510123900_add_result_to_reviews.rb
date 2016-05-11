class AddResultToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :result, :string, null: false
  end
end
