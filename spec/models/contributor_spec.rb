require 'rails_helper'

RSpec.describe Contributor, type: :model do
  # MISC MODEL TESTS
  it {should have_secure_password}

  # TEST ASSOCIATIONS
  it {should have_many(:comments)}
  it {should have_many(:flags)}
  it {should have_many(:reviews)}

  # TEST FOR PRESENCE OF DB COLUMNS

end
