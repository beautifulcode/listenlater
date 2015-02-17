
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

    it "creates a subscription locally" do
      click_link "Subscribe"
      Subscription.count.should eq(1)
      Subscription.last.series.should eql(Series.last)
    end

    it "doesn't send a request to SubscriptionService" do
      expect(SubscriptionService).to_not receive(:new)
      click_link "Subscribe"
    end

  end

end

describe "subscribing to an new series" do

  before do
    stub_subscription_service
    allow(SubscriptionService).to receive(:subscribe).and_return(true)

    @user = FactoryGirl.create :user
    log_in(@user)
    visit '/series/new'
  end

  context "with valid input" do

    before do
      fill_in "Title", :with => "New Podcast"
      fill_in "Url", :with => "http://test.com"
      click_button "Create Series"
    end

    it "creates a series & subscription locally" do
      Series.count.should eq(1)
      Subscription.count.should eq(1)
      Subscription.last.series.should eql(Series.last)
    end

    it "sends a request to SubscriptionService" do
      expect(SubscriptionService).to have_received(:subscribe).with("http://test.com", Series.last.uid)
    end

  end

end
