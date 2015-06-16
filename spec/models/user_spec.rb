require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it { should have_many(:packages) }
  it { should have_many(:ownerships) }

  it "invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "invalid with a duplicate username" do
    FactoryGirl.create(:user, username: "test")
    FactoryGirl.build(:user, username: "test").should_not be_valid
  end
end
