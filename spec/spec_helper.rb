DeprecationWarningError = Class.new(StandardError)

module RaiseOnDeprecationWarning
  # Gems announce deprecations in plain warnings without a category, hence the match on the message.
  def warn(message, category: nil, **options)
    raise DeprecationWarningError, message if category == :deprecated || message.match?(/deprecat/i)

    super
  end
end

Warning[:deprecated] = true
Warning.singleton_class.prepend(RaiseOnDeprecationWarning)

require "bundler/setup"
Bundler.setup
require File.expand_path(File.dirname(__FILE__) + "/../lib/ustidnr_validator")
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
RSpec.configure do |config|
  config.color = true
end
