require 'spec_helper'

describe "Listening to a source" do
  before do
    @user = FactoryGirl.create :user
    @source = FactoryGirl.create :source, :user => @user
    sign_in(@user)
    visit user_source_path(@user, @source)
  end

  it "tracks when a user clicks play", :js => true do
    click_link 'Play'
    @source.listens.count.should == 1
  end

  xit "tracks when a user clicks play then pause then play" do
    click_link 'Play'
    click_link 'Pause'
    click_link 'Play'
    @source.listens.count.should == 2
  end

end
