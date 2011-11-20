module Cucumber
  module Value
    # @author Colin Humphreys
    class ValueResults < Hash
      # Outputs whether value was delivered for each feature stored in the Hash
      def output
        self.each_pair do | feature, delivered |
          puts feature + " : "+ ( delivered ? "Delivered" : "Not delivered" )
        end
      end
    end
  end
end