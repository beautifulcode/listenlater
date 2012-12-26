require 'spec_helper'

describe Source do
  it "can be instantiated" do
    Source.new.should be_an_instance_of(Source)
  end

  it "can be saved successfully" do
    Source.create.should be_persisted
  end

  describe "#state_classes" do
    before do
      @source = FactoryGirl.create :source
    end

    it "should respond to state_classes with an array" do
      @source.state_classes.should == []
    end

  end
end
