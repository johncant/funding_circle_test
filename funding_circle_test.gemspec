# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'funding_circle_test/version'

Gem::Specification.new do |gem|
  gem.name          = "funding_circle_test"
  gem.version       = FundingCircleTest::VERSION
  gem.authors       = ["John Cant"]
  gem.email         = ["a.johncant@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "slop"
  gem.add_dependency "stream"
  gem.add_dependency "text-table"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
end
