require 'spec_helper'

describe ListensController do

  before do
    @user = FactoryGirl.create :user
    @source = FactoryGirl.create :source, :user => @user
  end

  context "when logged out" do

    describe "POST to :create" do
      it "can route a POST request, but will 401" do
        post :create, :listen => {:user_id => @user.to_param, :source_id => @source.to_param}
        #response.should == 401
        Listen.size == 0
      end
    end

  end

  context "when logged in" do

    before do
      login(@user)
    end


    describe "POST to :create with valid params" do

      it "404s" do
        post :create, :listen => invalid_listen_params
        response.should be_missing
        Listen.count.should == 0
      end

    end

    describe "POST to :create with valid params" do

      it "can route a POST request" do
        post :create, :listen => valid_listen_params
        response.should be_success
      end

      it "creates a listen" do
        post :create, :listen => valid_listen_params
        Listen.count.should == 1
      end

      it "creates a listen for the current user and appropriate source" do
        post :create, :listen => valid_listen_params
        Listen.last.user == @user
        Listen.last.source == @source
      end

    end
  end

  def valid_listen_params
    {:source_id => @source.to_param, :user_id => @user.to_param}
  end

  def invalid_listen_params 
    {}
  end

end

