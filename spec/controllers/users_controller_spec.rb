
require 'spec_helper'

describe UsersController do

  before do
    @user = FactoryGirl.create :user
    @other_user = FactoryGirl.create :user
  end

  describe "when logged out" do

    before do
      logout
    end

    describe "GET to :show" do
      it "can route a GET request to the user" do
        get :show, :id => @user.to_param
        response.should be_success
      end
    end

  end

  describe "when logged in" do

    before do
      login(@user)
    end

    describe "GET to :show" do

      it "can route a GET request" do
        get :show, :id => @user.to_param
        response.should be_success
      end

    end
  end

end
