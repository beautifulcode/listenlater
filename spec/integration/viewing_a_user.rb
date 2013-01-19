require 'spec_helper'

describe "Viewing a user" do

  before do
    stub_subscription_service
    @user = FactoryGirl.create :user
    @source = FactoryGirl.create :source, :user => @user
    @subscription = FactoryGirl.create :subscription, :user => @user
  end

  describe "when not signed in" do

    before do
      visit user_path(@user)
    end

    it "shows the user's sources" do
      page.has_content? @source.title
    end

    it "shows the user's subscriptions" do
      page.has_content? @subscription.title
    end

  end

  describe "when signed in" do

    before do
      sign_in(@user)
      visit user_path(@user)
    end

    it "shows the user's sources" do
      page.has_content? @source.title
    end

    it "shows the user's subscriptions" do
      page.has_content? @subscription.title
    end

  end

end
