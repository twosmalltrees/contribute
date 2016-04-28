require 'rails_helper'

RSpec.describe Forum, type: :model do
  # TEST ASSOCIATIONS
  it {should belong_to(:host_user)}
  it {should have_many(:comments)}

  # TEST FOR PRESENCE OF DB COLUMNS

end
