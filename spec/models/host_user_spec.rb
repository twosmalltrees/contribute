require 'rails_helper'

RSpec.describe HostUser, type: :model do
  # MISC MODEL TESTS
  it {should have_secure_password}

  # TEST ASSOCIATIONS
  it {should have_many(:forums)}

  # TEST FOR PRESENCE OF DB COLUMNS
end
