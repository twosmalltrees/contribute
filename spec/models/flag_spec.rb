require 'rails_helper'

RSpec.describe Flag, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:contributor)}
  it {should belong_to(:comment)}

  # VALIDATIONS
  it {should validate_presence_of(:contributor_id)}
  it {should validate_presence_of(:comment_id)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:contributor_id).of_type(:integer).with_options(null: false)}
  it {should have_db_column(:comment_id).of_type(:integer).with_options(null: false)}
  it {should have_db_column(:flag_reason_code).of_type(:integer).with_options(null: false)}
end
