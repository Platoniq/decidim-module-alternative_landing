# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/decidim_landing/version"

Gem::Specification.new do |s|
  s.version = Decidim::DecidimLanding::VERSION
  s.authors = ["Vera Rojman"]
  s.email = ["vera@platoniq.net"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/Platoniq/decidim-module-decidim_landing"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-decidim_landing"
  s.summary = "Decidim Landing Page"
  s.description = "A module to create better landing pages for Decidim"

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-admin", Decidim::DecidimLanding::DECIDIM_VERSION
  s.add_dependency "decidim-core", Decidim::DecidimLanding::DECIDIM_VERSION
  s.add_dependency "redcarpet", "~> 3.4"
  s.add_dependency "sassc", "~> 2.3"

  s.add_development_dependency "decidim-dev", Decidim::DecidimLanding::DECIDIM_VERSION
end
