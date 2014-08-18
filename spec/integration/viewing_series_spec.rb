require 'spec_helper'

describe "Viewing series listing" do
  before do
    @user = FactoryGirl.create :user
    @series = FactoryGirl.build :series
#    sign_in(@user)
    visit "/series"
  end

  it "shows the series" do
    page.has_css? '.series'
    page.has_content? @series.title
    page.has_content? @series.image_url
  end

end
