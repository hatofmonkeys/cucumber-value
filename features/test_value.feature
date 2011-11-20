Feature: test value
  In order to test the value of Cucumber features
  As a user of cucumber-value
  I want cucumber-value to be able to test for value

  Scenario: testable value tagging
    Given I have set up the environment with cucumber-value support
    And I have set up the addition feature
    When I run `bundle exec cucumber features/addition.feature`
    Then the stdout should contain:
      """
      Testable value : make 0 silly mistakes
      """

  Scenario: executing value tests
    Given I have set up the environment with cucumber-value support
    And I have set up the addition feature
    And I write to "features/step_definitions/addition.value" with:
      """
      In order to /^make 0 silly mistakes$/ do
        puts "Testing: make 0 silly mistakes"
      done
      """
    When I run `bundle exec cucumber features/addition.feature`
    Then the stdout should contain:
      """
      Testing: make 0 silly mistakes
      """

  Scenario: testing successful value delivery of a feature
    Given I have set up the environment with cucumber-value support
    And I have set up the working calculator with metrics
    And I have run some sample additions
    And I have set up the addition feature
    And I write to "features/step_definitions/addition.value" with:
      """
      In order to /^make 0 silly mistakes$/ do
        puts "Testing: make 0 silly mistakes"
        IO.read("metrics.txt") !~ /INCORRECT/
      done
      """
    When I run `bundle exec cucumber features/addition.feature`
    Then the stdout should contain:
      """
      : Delivered
      """

  Scenario: testing unsuccessful value delivery of a feature
    Given I have set up the environment with cucumber-value support
    And I have set up the broken calculator with metrics
    And I have run some sample additions
    And I have set up the addition feature
    And I write to "features/step_definitions/addition.value" with:
      """
      In order to /^make 0 silly mistakes$/ do
        puts "Testing: make 0 silly mistakes"
        IO.read("metrics.txt") !~ /INCORRECT/
      done
      """
    When I run `bundle exec cucumber features/addition.feature`
    Then the stdout should contain:
      """
      : Not delivered
      """