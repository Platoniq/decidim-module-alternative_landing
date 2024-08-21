# frozen_string_literal: true

require "spec_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/homepage_controller.rb" => "9fe738a33e271c92071e641be10a2833"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/controllers/decidim/participatory_processes/participatory_process_groups_controller.rb" => "ea8695da6fa62b2de904d0413579bf49"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])
    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
