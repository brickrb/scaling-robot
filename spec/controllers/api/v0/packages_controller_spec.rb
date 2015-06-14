require 'rails_helper'

RSpec.describe Api::V0::PackagesController, type: :controller do
  describe "GET #index" do
    it "returns http 200" do
      package = FactoryGirl.create(:package)
      get :index, format: :json
      response.status.should eq(200)
    end
  end

  describe "GET #show" do
    context "valid package" do
      it "returns http 200" do
        @package = FactoryGirl.create(:package)
        get :show, format: :json, name: @package.name
        response.status.should eq(200)
      end
    end

    context "invalid package" do
      it "returns http 404" do
        get :show, format: :json, name: "9000"
        response.status.should eq(404)
      end
    end
  end
end
