require 'spec_helper'

describe ListensController do

  before do
    @user = FactoryGirl.create :user
    @source = FactoryGirl.create :source, :user => @user
  end

  context "when logged out" do

    describe "POST to :create" do
      it "can route a POST request, but will 401" do
        post :create, :listen => {:user_id => @user.to_param, :source_id => @source.to_param}, :format => :json
        Listen.count == 0
      end
    end

  end

  context "when logged in" do

    before do
      login(@user)
    end


    describe "POST to :create with invalid params" do

      it "sends not acceptable" do
        post :create, :listen => invalid_listen_params, :format => :json
        response.status.should eq(422)
        Listen.count.should == 0
      end

    end

    describe "POST to :create with valid params" do

      before do
        post :create, :listen => valid_listen_params, :format => :json
      end

      it "can route a POST request" do
        response.should be_success
      end

      it "creates a listen" do
        Listen.count.should == 1
      end

      it "creates a listen for the current user and appropriate source" do
        Listen.last.user.should == @user
        Listen.last.source.should == @source
      end

      it "sets the source as listened" do
        @source.reload.listened.should == true
        Source.listened.count.should == 1
        Source.unlistened.count.should == 0
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

