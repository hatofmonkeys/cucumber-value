require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

require "cucumber/value/value_results"

module Cucumber
  module Value
    describe ValueResults do
      describe "output" do
        it "should output whether the value was delivered" do
          value_results = ValueResults.new
          value_results["Sample feature definition"] = true
          $stdout.should_receive(:puts).with(/Sample feature definition : Delivered/)
          value_results.output
        end
      end
    end
  end
end