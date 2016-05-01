require 'rails_helper'

RSpec.describe Review, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:comment)}
  it {should belong_to(:contributor)}

  # TEST VALIDATIONS
  it {should validate_presence_of(:comment_id)}
  it {should validate_presence_of(:contributor_id)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:comment_id)}
  it {should have_db_column(:contributor_id)}

end
