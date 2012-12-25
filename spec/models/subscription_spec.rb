require 'spec_helper'

describe Subscription do
  it "can be instantiated" do
    Subscription.new.should be_an_instance_of(Subscription)
  end

  it "can be saved successfully" do
    Subscription.create.should be_persisted
  end
end
