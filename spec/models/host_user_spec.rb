require 'rails_helper'

RSpec.describe HostUser, type: :model do
  # TEST ASSOCIATIONS
  it {should have_many(:forums)}

  # TEST FOR PRESENCE OF DB COLUMNS
end
