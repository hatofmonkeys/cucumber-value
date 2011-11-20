AfterConfiguration do
  #grab the tests out into a global hash - brutal
  puts "Parsing value tests..."
  $value_tests = {}
  pattern = %r/In order to (\/.*?\/) do([\d\D]*?)done/
  Dir.glob('features/step_definitions/*.value').each do |file|
    next unless File.file?(file)
      puts "Scanning for value tests in " + File.basename(file)
      value_test=(IO.read(file)).match(pattern)
      # Hash of regexs and their associated tests
      $value_tests[eval(value_test[1])] = Cucumber::Value::ValueTester.new value_test[2]
  end
  # Extended hash so it can output value delivery analysis - another nasty global
  $value_results = Cucumber::Value::ValueResults.new
end

Before('@testable-value') do |s|
  value = Regexp.new(/In order to (.*)$/).match(s.feature.description)[1].strip
  puts "Testable value : " +  value
  $value_tests.each do |regex, value_tester|
    if value.match(regex)
      puts "Testable value being executed..."
      value_tester.run_test
      $value_results[s.feature.description] = value_tester.value?
    end
  end
end

at_exit do
  $value_results.output
end