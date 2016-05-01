require 'rails_helper'

RSpec.describe HostUser, type: :model do
  # TEST ASSOCIATIONS
  it {should have_many(:forums)}
  it {should have_many(:discussions).through(:forums)}


  # TEST VALIDATIONS


  # TEST FOR PRESENCE OF DB COLUMNS


end
