require 'rails_helper'

RSpec.describe PackagesController, type: :controller do

  describe "GET #show" do
    context "valid package" do
      it "returns http 200" do
        @package = FactoryGirl.create(:package)
        get :show, name: @package.name
        response.status.should eq(200)
      end
    end
  end
end
