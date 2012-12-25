require 'spec_helper'

describe User do
  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end

  describe "with invalid attributes" do

    it "cannot be saved successfully" do
      User.create(invalid_user_params).should_not be_persisted
    end

  end


  describe "with valid attributes" do

    it "can be saved successfully" do
      User.create(valid_user_params).should be_persisted
    end

  end


  def valid_user_params
    FactoryGirl.attributes_for(:user)
  end

  def invalid_user_params
    {}
  end

end
