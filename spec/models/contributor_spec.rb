require 'rails_helper'

RSpec.describe Contributor, type: :model do
  # TEST ASSOCIATIONS
  it {should have_many(:comments)}
  it {should have_many(:flags)}
  it {should have_many(:reviews)}
  it {should have_many(:upvotes)}
  it {should have_secure_password}

  # VALIDATIONS
  it {should validate_presence_of(:username)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_uniqueness_of(:email)}
  it {should validate_presence_of(:reputation)}
  it {should validate_presence_of(:blocked)}

  # TEST FOR PRESENCE OF DB COLUMNS
  it {should have_db_column(:password_digest).of_type(:string).with_options(null: false)}
  it {should have_db_column(:username).of_type(:string).with_options(null: false)}
  it {should have_db_column(:email).of_type(:string).with_options(null: true)}
  it {should have_db_column(:reputation).of_type(:integer).with_options(null: false, default: 0)}
  it {should have_db_column(:blocked).of_type(:boolean).with_options(null: false, default: false)}
end
