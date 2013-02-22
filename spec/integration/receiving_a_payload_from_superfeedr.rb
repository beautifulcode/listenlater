require 'spec_helper'

#describe "Receiving a JSON payload from superfeedr", :type => :controller do

  #before do
    #stub_subscription_service
    #@user = FactoryGirl.create :user, :last_sign_in_at => 1.day.ago
    #@subscription = FactoryGirl.create :subscription, :user => @user
    #@raw_json = JSON.parse(File.read("spec/support/sample.json")).to_json
    #@json = JSON.parse(@raw_json)
  #end

  #it "sends a json object to the SubscriptionService#receive method" do
    #SubscriptionService.should_receive(:receive).with(@json, "#{@subscription.id}")
    #post "superfeedr/feed/#{@subscription.id}", @raw_json, 'CONTENT_TYPE' => 'application/json'
  #end

  #it "creates a source for the subscription" do
    #post "superfeedr/feed/#{@subscription.id}", @raw_json, 'CONTENT_TYPE' => 'application/json'
    #@subscription.sources.size.should eq(1)
  #end

#end

describe "Receiving a XML payload from superfeedr", :type => :controller do

  before do
    stub_subscription_service
    @user = FactoryGirl.create :user, :last_sign_in_at => 1.day.ago
    @subscription = FactoryGirl.create :subscription, :user => @user
    @raw_xml = File.read("spec/support/sample.xml")
    @xml = Nokogiri::XML(@raw_xml)
  end

  it "sends a xml object to the SubscriptionService#receive method" do
    SubscriptionService.should_receive(:receive)
    post "superfeedr/feed/#{@subscription.id}", @raw_xml, 'CONTENT_TYPE' => 'application/atom+xml'
  end

  it "creates a source for the subscription" do
    post "superfeedr/feed/#{@subscription.id}", @raw_xml, 'CONTENT_TYPE' => 'application/atom+xml'
    @subscription.sources.size.should eq(1)
    @subscription.sources.last.title.should eq('The Frequency 60: 1080-Frickin-P')
    @subscription.sources.last.url.should eq('http://d.ahoy.co/redirect.mp3/fly.5by5.tv/audio/broadcasts/frequency/2013/frequency-060.mp3')
  end

  it "assigns the source to the user" do
    post "superfeedr/feed/#{@subscription.id}", @raw_xml, 'CONTENT_TYPE' => 'application/atom+xml'
    Source.last.user.should == @user
  end

end
