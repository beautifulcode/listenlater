

require 'spec_helper'

describe "Listing various sources" do
  before do
    @user = FactoryGirl.create :user
    @recent_source = FactoryGirl.create :source
    sign_in(@user)
  end

  it "allows the user to view recent sources" do
    visit 'sources/recent'
    page.has_content? @recent_source.title
  end

  it "allows the user to see already listened sources" do
    visit 'sources/recent'
    #@listened_source = FactoryGirl.create :source, :listened => true
    page.has_css? '.listened'
  end



  def sign_in(user)
    visit '/'
    click_link 'email_sign_in'
    fill_in 'Email', :with => user.email
    fill_in 'user_password', :with => 'abc123'
    click_button 'Sign in'
  end

end
