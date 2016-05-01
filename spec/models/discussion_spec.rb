require 'rails_helper'

RSpec.describe Discussion, type: :model do
  # TEST ASSOCIATIONS
  it {should have_many(:comments)}
  it {should belong_to(:forum)}


  # VALIDATIONS
  it {should validate_presence_of(:forum_id)}
  it {should validate_presence_of(:unique_page_identifier)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:forum_id).of_type(:integer).with_options(null: false)}
  it {should have_db_column(:page_url).of_type(:string)}
  it {should have_db_column(:unique_page_identifier).of_type(:string).with_options(null: false)}

end
