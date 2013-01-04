
require 'spec_helper'

describe "creating a subscription" do
  before do
    @user = FactoryGirl.create :user
    sign_in(@user)
    visit new_subscription_path
  end

  context "with valid input" do

    before do
      fill_in 'Title', :with => 'Awesome Podcast Number 1'
      fill_in 'Url', :with => 'http://something.com/feed.rss'
    end

    it "creates a subscription locally" do
      click_button 'Create'
      Subscription.count.should eq(1)
    end

    xit "sends a request to SubscriptionService" do
    end

    xit "receives a response from SubscriptionService" do
    end


  end

end
