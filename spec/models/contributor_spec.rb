require 'rails_helper'

RSpec.describe Contributor, type: :model do
  # TEST ASSOCIATIONS
  it {should have_many(:comments)}
  it {should have_many(:flags)}
  it {should have_many(:reviews)}

  # TEST FOR PRESENCE OF DB COLUMNS
end
