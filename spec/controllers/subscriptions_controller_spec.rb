
require 'spec_helper'

describe SubscriptionsController do

  describe "when logged in" do

    before do
      logout
    end

    describe "POST to :create" do
      it "can route a POST request, but will 401" do
        post :create, :subscription => invalid_subscription_params
        #response.should == 401
      end
    end

  end

  describe "when logged in" do

    before do
      user = FactoryGirl.create :user
      login(user)
    end

    describe "POST to :create" do
      before do
      end

      it "can route a POST request" do
        post :create, :subscription => valid_subscription_params
        response.should be_redirect
        response.should redirect_to(Subscription.last)
      end

      it "creates a subscription" do
        post :create, :subscription => valid_subscription_params
        Subscription.count.should == 1
      end

      it "creates a subscription for the current user" do
        post :create, :subscription => valid_subscription_params
        Subscription.last.user == User.last
      end

    end
  end

  def valid_subscription_params
    {:url => 'http://mycoolsite.com/podcast.rss'}
  end

  def invalid_subscription_params 
    {}
  end



end
