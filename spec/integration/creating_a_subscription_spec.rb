
require 'spec_helper'

describe "subscribing to an existing series" do
  before do
    stub_subscription_service
    @user = FactoryGirl.create :user
    @series = FactoryGirl.build :series
#    sign_in(@user)
    visit '/series'
  end

  context "with valid input" do

    it "creates a series & subscription locally" do
      click_link "Subscribe"
      Subscription.count.should eq(1)
      Subscription.last.should eql(Series.last)
    end

    xit "sends a request to SubscriptionService" do
    end

    xit "receives a response from SubscriptionService" do
    end


  end

end
