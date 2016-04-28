require 'rails_helper'

RSpec.describe Comment, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:contributor)}
  it {should belong_to(:forum)}
  it {should have_many(:flags)}
  it {should have_many(:reviews)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column( :body_text )}
end
