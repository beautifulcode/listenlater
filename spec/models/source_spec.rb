require 'spec_helper'

describe Source do
  it "can be instantiated" do
    Source.new.should be_an_instance_of(Source)
  end

  it "can be saved successfully" do
    Source.create.should be_persisted
  end
end
