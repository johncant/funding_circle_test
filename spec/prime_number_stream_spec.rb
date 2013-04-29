require 'spec_helper'
require 'timeout'

describe "FundingCircleTest#prime_number_stream" do

  subject { FundingCircleTest.prime_number_stream }

  it "returns a list of numbers" do
    subject.take(3).each do |n|
      n.should be_a Numeric
    end
  end

  it "starts with 2" do
    subject.first.should == 2
  end

  it "returns correct prime numbers" do
    subject.take(498).last.should == 3557
  end

end
