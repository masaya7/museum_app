ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
#require "bootstrap/setup" # Speed up boot time by caching expensive operations.
