
require 'spec_helper'

describe "Signing in" do
  before do
    @user = FactoryGirl.create :user, :last_sign_in_at => 1.day.ago
  end

  it "allows me to signin via link on the homepage" do
    visit '/'
    click_link 'email_sign_in'
    fill_in 'Email', :with => @user.email
    fill_in 'user_password', :with => 'abc123'
    click_button 'Sign in'
    current_path.should == '/'
  end

end
