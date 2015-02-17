require 'spec_helper'

describe SourcesController do
  before do
    stub_subscription_service
  end

  describe "when logged in" do

    before do
      @user = FactoryGirl.create :user
      @source = FactoryGirl.create :source
      logout
    end

    describe "GET to :show" do
      it "can route to show" do
        get :show, :id => @source.to_param
        response.should be_success
      end

      it "can be nested under a user" do
        get :show, :id => @source.to_param, :user_id => @user.to_param
        response.should be_success
      end
    end

    describe "POST to :create" do
      it "can route a POST request, but will 401" do
        post :create, :source => invalid_source_params
        #response.should == 401
      end
    end

  end

  describe "when logged in" do

    before do
      @user = FactoryGirl.create :user
      login(@user)
    end

    describe "POST to :create" do
      before do
      end

      it "can route a POST request" do
        post :create, :source => valid_source_params
        response.should be_redirect
        response.should redirect_to(Source.last)
      end

      it "creates a source" do
        post :create, :source => valid_source_params
        Source.count.should == 1
      end

      describe "callback from superfeedr with series uid" do

        it "creates a source for that series" do
          series = FactoryGirl.create :series
          post :create, :source => valid_source_params.merge(:series_id => series.uid)
          expect(series.reload.sources.size).to eq(1)
        end

      end

    end
  end

  def valid_source_params
    {:url => 'http://mycoolsite.com/podcast.mp3'}
  end

  def invalid_source_params
    {}
  end



end
