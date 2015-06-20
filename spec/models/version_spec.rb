require 'rails_helper'

RSpec.describe Version, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:version).should be_valid
  end

  it { should belong_to(:package) }

  it "invalid without a license" do
    FactoryGirl.build(:version, license: nil).should_not be_valid
  end

  it "invalid without a number" do
    FactoryGirl.build(:version, number: nil).should_not be_valid
  end

  it "invalid with a duplicate number" do
    FactoryGirl.create(:version, number: "1.0.0")
    FactoryGirl.build(:version, number: "1.0.0").should_not be_persisted
  end
end
