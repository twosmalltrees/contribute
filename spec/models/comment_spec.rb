require 'rails_helper'

RSpec.describe Comment, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:contributor)}
  it {should belong_to(:forum)}
  it {should have_many(:flags)}
  it {should have_many(:reviews)}
  it {should have_many(:upvotes)}

  # VALIDATIONS
  it {should validate_presence_of(:contributor_id)}
  it {should validate_presence_of(:forum_id)}
  it {should validate_presence_of(:pending)}
  it {should validate_presence_of(:removed)}
  it {should validate_presence_of(:status)}
  it {should validate_presence_of(:is_reply)}
  it {should validate_presence_of(:body_text)}
  it {should validate_length_of(:body_text).is_at_least(5).on(:create)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:contributor_id).of_type(:integer).with_options(null: false)}
  it {should have_db_column(:forum_id).of_type(:integer).with_options(null: false)}
  it {should have_db_column(:pending).of_type(:boolean).with_options(default: true)}
  it {should have_db_column(:removed).of_type(:boolean).with_options(default: false)}
  it {should have_db_column(:status).of_type(:string).with_options(default: "pending")}
  it {should have_db_column(:is_reply).of_type(:boolean).with_options(default: false)}
  it {should have_db_column(:reply_to).of_type(:integer)}
  it {should have_db_column(:body_text).of_type(:text).with_options(null: false)}

end
