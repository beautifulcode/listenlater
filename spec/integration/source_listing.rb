

require 'spec_helper'

describe "Listing recent sources" do

  before do
    @user = FactoryGirl.create :user
    @recent_source = FactoryGirl.create :source
    sign_in(@user)
    visit 'sources/recent'
  end

  it "contains SM2 markup" do
    page.has_css? '#sm2-container'
    page.has_css? 'ul.playlist li a'
  end

  it "contains the title of the source" do
    page.has_content? @recent_source.title
  end

  it "contains the url of the source" do
    page.has_content? @recent_source.url
  end

  it "allows the user to see already listened sources" do
    #@listened_source = FactoryGirl.create :source, :listened => true
    #page.has_css? '.listened'
  end

end
