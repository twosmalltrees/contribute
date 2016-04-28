require 'rails_helper'

RSpec.describe Review, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:comment)}
  it {should belong_to(:contributor)}
  # TEST FOR PRESENCE OF DB COLUMNS
end
