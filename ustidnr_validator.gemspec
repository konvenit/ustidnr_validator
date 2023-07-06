# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ustidnr_validator/version"

Gem::Specification.new do |spec|
  spec.name          = "ustidnr_validator"
  spec.version       = UstidnrValidator::VERSION
  spec.authors       = "miceportal team"
  spec.email         = "info@miceportal.com"
  spec.description   = %q{Ustidnr Validator}
  spec.summary       = %q{ Ustidnr Validat }
  spec.homepage      = "http://www.miceportal.com"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]
  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"
  spec.add_dependency "xmlrpc"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "rspec-mocks"
end
