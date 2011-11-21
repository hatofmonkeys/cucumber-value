$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'simplecov'
require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 30
  unset_bundler_env_vars
end

SimpleCov.start