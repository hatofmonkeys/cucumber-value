# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cucumber-value"
  s.version     = "0.0.1"
  s.authors     = ["Colin Humphreys"]
  s.homepage    = "https://github.com/hatofmonkeys/cucumber-value"
  s.summary     = "#{s.name}-#{s.version}"
  s.description = "Assert the value of Cucumber features"
  s.license     = 'MIT'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = "lib"

  s.add_development_dependency "rspec"
  s.add_development_dependency "cucumber"
  s.add_development_dependency "yard"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-cucumber"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "aruba"
  s.add_runtime_dependency "cucumber"
end
