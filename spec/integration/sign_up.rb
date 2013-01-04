require 'spec_helper'

describe "Signing up for the first time" do

  it "allows me to signup via link on the homepage" do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'user_password', :with => 'secret'
    fill_in 'user_password_confirmation', :with => 'secret'
    click_button 'Register'
    User.count.should == 1
    current_path.should == '/welcome'
  end

end
