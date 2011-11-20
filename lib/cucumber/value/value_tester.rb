module Cucumber
  module Value
    # @author Colin Humphreys
    class ValueTester
      # Initialises the ValueTester
      # @param [String] test the code block to be executed for the value test
      def initialize(test)
        @test = test
      end
      # Runs the test block
      def run_test
        begin
          @value = eval @test
        rescue Exception => exc
          # TODO: something sensible when tests aren't valid
          @value = false
        end
      end
      # Getter for whether the value has been delivered
      # @return [Boolean] has the test passed?
      def value?
        @value
      end
    end
  end
end