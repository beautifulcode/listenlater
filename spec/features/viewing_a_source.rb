require 'spec_helper'

describe "Viewing a given source" do
  before do
    @user = FactoryGirl.create :user
    @source = FactoryGirl.create :source, :created_at => 2.days.ago
    @recent_source = FactoryGirl.create :source, :created_at => 1.day.ago
    @older_source = FactoryGirl.create :source, :created_at => 1.week.ago
    sign_in(@user)
    visit "sources/#{@source.to_param}"
  end

  it "shows the player" do
    page.has_css? '.player'
    page.has_content? @source.title
  end
  
  it "shows the recent source" do
    page.has_content? @recent_source.title
  end

  it "shows the older source" do
    page.has_content? @older_source.title
  end



  def sign_in(user)
    visit '/'
    click_link 'email_sign_in'
    fill_in 'Email', :with => user.email
    fill_in 'user_password', :with => 'abc123'
    click_button 'Sign in'
  end

end
