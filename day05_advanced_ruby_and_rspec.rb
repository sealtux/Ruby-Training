# Run: ruby day05_advanced_ruby_and_rspec.rb
require "bundler/setup"
require "rspec/core"
exit RSpec::Core::Runner.run([File.join(__dir__, "spec/shopping_cart_spec.rb"), "--format", "documentation"])
