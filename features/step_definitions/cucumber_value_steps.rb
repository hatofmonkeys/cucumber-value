Given /^I have set up the environment with cucumber\-value support$/ do
  steps %Q{
    When I append to "Gemfile" with:
      """
      gem "cucumber-value", :group => :test, :path => "../.."
      gem "rspec", :group => :test

      """
    And I append to "features/support/env.rb" with:
      """
      require 'cucumber/value'
      require 'rspec'

      """
  }
end

Given /^I have set up the addition feature$/ do
  steps %Q{
    When I write to "features/addition.feature" with:
      """
      @testable-value
      Feature: Addition
        In order to make 0 silly mistakes
        As a math idiot
        I want to be told the sum of two numbers

        Scenario: Add two numbers
          Given I have entered 50 into the calculator
          And I have entered 70 into the calculator
          When I press add
          Then the result should be 120 on the screen

      """
    And I write to "features/step_definitions/addition_steps.rb" with:
      """
      Given /I have entered (.*) into the calculator/ do |n|
        @calculator ||= Calculator.new
        @calculator.push(n.to_i)
      end

      When /I press add/ do
        @calculator.add
      end

      Then /the result should be (.*) on the screen/ do |n|
         @calculator.screen.should == n
      end

      """
  }
end

Given /^I have set up the working calculator with metrics$/ do
  steps %Q{
    When I append to "lib/calculator.rb" with:
      """
      class Calculator
        def initialize
          @screen = 0
        end
        def push(n)
          @args ||= []
          @args << n
        end
        def add
          @screen = generate_answer
          metric = @screen == @args[0] + @args[1] ? "CORRECT" : "INCORRECT"
          File.open("metrics.txt", 'a') {|f| f.puts(metric) }
        end
        def screen
          @screen.to_s
        end
        def generate_answer
          @args.inject(0){|sum,item| sum + item}
        end
      end

      """
    And I append to "features/support/env.rb" with:
      """
      $:.unshift(File.dirname(__FILE__) + '/../../lib')
      require 'calculator'

      """
  }
end

Given /^I have set up the broken calculator with metrics$/ do
  steps %Q{
    Given I have set up the working calculator with metrics
    And I append to "lib/calculator.rb" with:
      """
      class Calculator
        def generate_answer
          120
        end
      end

      """
  }
end


Given /^I have run some sample additions$/ do
  steps %Q{
    When I append to "sample-additions.rb" with:
      """
      load "lib/calculator.rb"
      (1..5).to_a.each_with_index do |i,k|
        calc = Calculator.new
        calc.push i
        calc.push k
        calc.add
      end

      """
    And I run `ruby sample-additions.rb`
  }
end