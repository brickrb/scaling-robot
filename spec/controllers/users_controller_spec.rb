require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #show" do
    before { @user = FactoryGirl.create(:user) }
    it "renders the show template and returns http 200" do
      get :show, username: @user.username
      response.should render_template("show")
      response.status.should eq(200)
    end
  end

end
