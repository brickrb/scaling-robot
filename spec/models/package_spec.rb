require 'rails_helper'

RSpec.describe Package, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:package).should be_valid
  end
end
