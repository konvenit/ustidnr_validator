# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ustidnr_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "ustidnr_validator"
  spec.version       = UstidnrValidator::VERSION
  spec.authors       = "miceportal team"
  spec.email         = "info@eventbs.de"
  spec.description   = %q{Ustidnr Validator}
  spec.summary       = %q{ Ustidnr Validat }
  spec.homepage      = "http://www.eventbs.de"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]
  spec.add_dependency 'activesupport', "~> 3.1"
  spec.add_dependency 'activemodel',   "~> 3.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rb-fsevent'

end
