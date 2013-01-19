require 'spec_helper'

describe "Listening to a source" do
  before do
    @user = FactoryGirl.create :user
    @source = FactoryGirl.create :source, :user => @user
    #sign_in(@user)
    #stub_request(:get, "http://127.0.0.1:*/__identify__").
         #with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         #to_return(:status => 200, :body => "", :headers => {})
    visit "/users/#{@user.to_param}/sources/#{@source.to_param}"
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
