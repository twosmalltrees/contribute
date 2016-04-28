require 'rails_helper'

RSpec.describe Flag, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:contributor)}
  it {should belong_to(:comment)}

  # TEST FOR PRESENCE OF DB COLUMNS

end
