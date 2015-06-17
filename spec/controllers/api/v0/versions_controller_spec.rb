require 'rails_helper'

RSpec.describe Api::V0::VersionsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }
  before { controller.stub(:current_user).and_return user }

  context "no access token" do
    it 'returns a 401 when users are not authenticated' do
      post :create, format: :json, name: FactoryGirl.build(:package).name, version: FactoryGirl.attributes_for(:version)
      response.status.should eq(401)
    end
  end

  context "with access token" do
    before(:each) do
      @oauth_application = FactoryGirl.build(:oauth_application)
      @token = Doorkeeper::AccessToken.create!(:application_id => @oauth_application.id, :resource_owner_id => user.id)
    end

    describe "POST #create" do
      context "valid parameters" do
        before { @package = FactoryGirl.create(:package) }
        before { @ownership = FactoryGirl.create(:ownership) }
        it "creates a pacakge" do
          expect {
            post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version)
          }.to change(Version, :count).by(1)
        end

        it "returns http 201" do
          post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version)
          response.status.should eq(201)
        end
      end

      context "invalid parameters (no license)" do
        before { @package = FactoryGirl.create(:package) }
        before { @ownership = FactoryGirl.create(:ownership) }
        it "does not create a version" do
          expect {
            post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version, license: nil)
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version, license: nil)
          response.status.should eq(422)
        end
      end

      context "invalid parameters (no number)" do
        before { @package = FactoryGirl.create(:package) }
        before { @ownership = FactoryGirl.create(:ownership) }
        it "does not create a version" do
          expect {
            post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version, number: nil)
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version, number: nil)
          response.status.should eq(422)
        end
      end

      context "invalid parameters (duplicate number)" do
        before { @package = FactoryGirl.create(:package) }
        before { @ownership = FactoryGirl.create(:ownership) }
        before { @version = FactoryGirl.create(:version, number: "1.0.0") }
        it "does not create a version" do
          expect {
            post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version, number: "1.0.0")
          }.to change(Version, :count).by(0)
        end

        it "returns http 422" do
          post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version, number: "1.0.0")
          response.status.should eq(422)
        end
      end

      context "invalid parameters (no ownership)" do
        before { @package = FactoryGirl.create(:package) }
        it "does not create a version" do
          expect {
            post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version)
          }.to change(Version, :count).by(0)
        end

        it "returns http 401" do
          post :create, format: :json, access_token: @token.token, name: @package.name, version: FactoryGirl.attributes_for(:version)
          response.status.should eq(401)
        end
      end
    end
  end
end
