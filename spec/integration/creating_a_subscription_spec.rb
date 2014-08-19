
require 'spec_helper'

describe "subscribing to an existing series" do
  before do
    stub_subscription_service

    @user = FactoryGirl.create :user
    @series = FactoryGirl.create :series
#    sign_in(@user)
    visit '/series'
  end

  context "with valid input" do

    it "creates a series & subscription locally" do
      click_link "Subscribe"
      Subscription.count.should eq(1)
      Subscription.last.series.should eql(Series.last)
    end

    it "doesn't send a request to SubscriptionService" do
      expect(SubscriptionService).to_not receive(:new)
      click_link "Subscribe"
    end

    xit "receives a response from SubscriptionService" do
    end


  end

end
