# frozen_string_literal: true

require "decidim/dev"

require "simplecov"
SimpleCov.start "rails" do
  add_filter "lib/decidim/alternative_landing/version.rb"
  add_filter "lib/tasks"
end
if ENV["CODECOV"]
  require "codecov"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

ENV["ENGINE_ROOT"] = File.dirname(__dir__)

Decidim::Dev.dummy_app_path =
  File.expand_path(File.join(__dir__, "decidim_dummy_app"))

require "decidim/dev/test/base_spec_helper"
