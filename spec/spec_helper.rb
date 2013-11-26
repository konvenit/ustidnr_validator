require 'rubygems'
require File.expand_path(File.dirname(__FILE__) + "/../lib/ustidnr_validator")
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

RSpec.configure do |config|
  config.color_enabled = true
end
