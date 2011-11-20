require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

require "cucumber/value/value_tester"

module Cucumber
  module Value
    describe ValueTester do
      before :each do
        @valueTester = ValueTester.new "true"
      end
      describe "#new" do
        it "should take a String parameter and return a ValueTester object" do
          @valueTester.should be_an_instance_of ValueTester
        end
      end
      describe "#run_test" do
        it "should run the test code" do
          @valueTester.run_test.should eql true
        end
        it "should not collapse and burn with an invalid test" do
          badValueTester = ValueTester.new "gefafwsp"
          badValueTester.run_test.should eql false
        end
      end
      describe "#value?" do
        it "should return whether the value was delivered" do
          @valueTester.run_test
          @valueTester.value?.should eql true
        end
      end
    end
  end
end