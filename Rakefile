# frozen_string_literal: true

require "decidim/dev/common_rake"
require "fileutils"

desc "Generates a dummy app for testing"
task test_app: "decidim:generate_external_test_app" do
  ENV["RAILS_ENV"] = "test"
  override_webpacker_config_files("spec/decidim_dummy_app")
end

def override_webpacker_config_files(path)
  Dir.chdir(path) do
    system("bundle exec rake decidim_alternative_landing:webpacker:install")
  end
end

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

desc "Generates a development app."
task :development_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      "..",
      "--recreate_db",
      "--demo"
    )
  end

  seed_db("development_app")
  override_webpacker_config_files("development_app")
end
