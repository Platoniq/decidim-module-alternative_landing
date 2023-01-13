# frozen_string_literal: true

require "decidim/gem_manager"

namespace :decidim_alternative_landing do
  namespace :webpacker do
    desc "Installs Decidim Alternative Landing webpacker files in Rails instance application"
    task install: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_decidim_alternative_landing_npm
    end

    desc "Adds Decidim Alternative Landing dependencies in package.json"
    task upgrade: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_decidim_alternative_landing_npm
    end

    def install_decidim_alternative_landing_npm
      decidim_alternative_landing_npm_dependencies.each do |type, packages|
        system! "npm i --save-#{type} #{packages.join(" ")}"
      end
    end

    def decidim_alternative_landing_npm_dependencies
      @decidim_alternative_landing_npm_dependencies ||= begin
                                                          package_json = JSON.parse(File.read(decidim_alternative_landing_path.join("package.json")))

                                                          {
                                                            prod: package_json["dependencies"].map { |package, version| "#{package}@#{version}" },
                                                            dev: package_json["devDependencies"].map { |package, version| "#{package}@#{version}" }
                                                          }.freeze
                                                        end
    end

    def decidim_alternative_landing_path
      @decidim_alternative_landing_path ||= Pathname.new(decidim_alternative_landing_gemspec.full_gem_path) if Gem.loaded_specs.has_key?(gem_name)
    end

    def decidim_alternative_landing_gemspec
      @decidim_alternative_landing_gemspec ||= Gem.loaded_specs[gem_name]
    end

    def rails_app_path
      @rails_app_path ||= Rails.root
    end

    def copy_alternative_landing_file_to_application(origin_path, destination_path = origin_path)
      FileUtils.cp(decidim_alternative_landing_path.join(origin_path), rails_app_path.join(destination_path))
    end

    def system!(command)
      system("cd #{rails_app_path} && #{command}") || abort("\n== Command #{command} failed ==")
    end

    def gem_name
      "decidim-alternative_landing"
    end
  end
end
