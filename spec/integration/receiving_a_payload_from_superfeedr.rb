require 'spec_helper'

describe "Receiving a JSON payload from superfeedr", :type => :controller do

  before do
    @user = FactoryGirl.create :user, :last_sign_in_at => 1.day.ago
    @subscription = FactoryGirl.create :subscription, :user => @user
    @raw_json = JSON.parse(File.read("spec/support/sample.json")).to_json
    @json = JSON.parse(@raw_json)
  end

  it "sends a json object to the SubscriptionService#receive method" do
    SubscriptionService.should_receive(:receive).with(@json, "#{@subscription.id}")
    post "superfeedr/feed/#{@subscription.id}", @raw_json, 'CONTENT_TYPE' => 'application/json'
  end

  it "creates a source for the subscription" do
    post "superfeedr/feed/#{@subscription.id}", @raw_json, 'CONTENT_TYPE' => 'application/json'
    @subscription.sources.size.should eq(1)
  end

end
