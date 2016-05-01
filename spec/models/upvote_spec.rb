require 'rails_helper'

RSpec.describe Upvote, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:contributor)}
  it {should belong_to(:comment)}

  # VALIDATIONS
  it {should validate_presence_of(:contributor_id)}
  it {should_validate_presence_of(:comment_id)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:contributor_id)}
  it {should have_db_column(:comment_id)}
end
