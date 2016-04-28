require 'rails_helper'

RSpec.describe Contributor, type: :model do
  # MISC MODEL TESTS
  it {should have_secure_password}

  # VALIDATIONS
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:reputation)}
  it {should validate_presence_of(:blocked)}

  # TEST ASSOCIATIONS
  it {should have_many(:comments)}
  it {should have_many(:flags)}
  it {should have_many(:reviews)}
  it {should have_many(:upvotes)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:password_digest).of_type(:string).with_options(null: false)}
  it {should have_db_column(:username).of_type(:string).with_options(null: false)}
  it {should have_db_column(:email).of_type(:string).with_options(null: true)}
  it {should have_db_column(:reputation).of_type(:integer).with_options(default: 0, null: false)}
  it {should have_db_column(:blocked).of_type(:boolean).with_options(default: false, null: false)}

end
