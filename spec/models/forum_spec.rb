require 'rails_helper'

RSpec.describe Forum, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:host_user)}
  it {should have_many(:discussions)}
  it {should have_many(:comments).through(:discussions)}

  # VALIDATIONS
  it {should validate_presence_of(:host_user_id)}
  it {should validate_presence_of(:root_domain)}
  it {should validate_presence_of(:forum_shortname)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:host_user_id)}
  it {should have_db_column(:root_domain).of_type(:string).with_options(null: false)}
  it {should have_db_column(:forum_shortname).of_type(:string).with_options(null: false)}
end
