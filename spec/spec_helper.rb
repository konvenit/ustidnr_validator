require 'bundler/setup'
Bundler.setup
require File.expand_path(File.dirname(__FILE__) + "/../lib/ustidnr_validator")
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
RSpec.configure do |config|
  config.color = true
end
