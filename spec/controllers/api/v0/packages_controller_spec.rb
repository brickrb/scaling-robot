require 'rails_helper'

RSpec.describe Api::V0::PackagesController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }
  before { controller.stub(:current_user).and_return user }

  context "no access token" do
    it 'returns a 401 when users are not authenticated' do
      get :index, format: :json
      response.status.should eq(401)
    end
    it 'returns a 401 when users are not authenticated' do
      post :create, format: :json, package: FactoryGirl.attributes_for(:package)
      response.status.should eq(401)
    end
    it 'returns a 401 when users are not authenticated' do
      get :show, format: :json, name: FactoryGirl.create(:package)
      response.status.should eq(401)
    end
    it 'returns a 401 when users are not authenticated' do
      delete :destroy, format: :json, name: FactoryGirl.create(:package)
      response.status.should eq(401)
    end
  end

  context "with access token" do
    before(:each) do
      @oauth_application = FactoryGirl.build(:oauth_application)
      @token = Doorkeeper::AccessToken.create!(:application_id => @oauth_application.id, :resource_owner_id => user.id)
    end

    describe "GET #index" do
      it "returns http 200" do
        package = FactoryGirl.create(:package)
        get :index, format: :json, access_token: @token.token
        response.status.should eq(200)
      end
    end

    describe "GET #show" do
      context "valid package" do
        it "returns http 200" do
          @package = FactoryGirl.create(:package)
          get :show, format: :json, access_token: @token.token, name: @package.name
          response.status.should eq(200)
        end
      end

      context "invalid package" do
        it "returns http 404" do
          get :show, format: :json, access_token: @token.token, name: "9000"
          response.status.should eq(404)
        end
      end
    end

    describe "POST #create" do
      context "valid parameters" do
        it "creates a pacakge" do
          expect {
            post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package)
          }.to change(Package, :count).by(1)
        end

        it "creates an ownership" do
          expect {
            post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package)
          }.to change(Ownership, :count).by(1)
        end

        it "returns http 201" do
          post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package)
          response.status.should eq(201)
        end
      end

      context "invalid parameters (no name)" do
        it "does not create a pacakge" do
          expect {
            post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package, name: nil)
          }.to change(Package, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package, name: nil)
          response.status.should eq(422)
        end
      end

      context "invalid parameters (duplicate name)" do
        before { FactoryGirl.create(:package, name: "rails") }
        it "does not create a pacakge" do
          expect {
            post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package, name: "rails")
          }.to change(Package, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, package: FactoryGirl.attributes_for(:package, name: "rails")
          response.status.should eq(422)
        end
      end
    end

    describe "DELETE #destroy" do
      context "valid parameters" do
        before { @package = FactoryGirl.create(:package) }
        before { @ownership = FactoryGirl.create(:ownership) }
        it "deletes the package" do
          expect {
            delete :destroy, format: :json, access_token: @token.token, name: @package.name, package: @package
          }.to change(Package, :count).by(-1)
        end

        it "deletes the ownership" do
          expect {
            delete :destroy, format: :json, access_token: @token.token, name: @package.name, package: @package
          }.to change(Ownership, :count).by(-1)
        end

        it "returns 204" do
          delete :destroy, format: :json, access_token: @token.token, name: @package.name, package: @package
          response.status.should eq(204)
        end
      end
    end
  end
end
