require 'spec_helper'

describe "Viewing the bookmarklet" do
  before do
    @user = FactoryGirl.create :user
    sign_in(@user)
    visit "bookmarklet"
  end

  it "shows the js" do
    expect(page.body).to include('add_source')
  end

end
