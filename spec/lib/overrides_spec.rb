# frozen_string_literal: true

require "spec_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/homepage_controller.rb" => "5936c8bd9d20c719238397cb5b12b44d"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/controllers/decidim/participatory_processes/participatory_process_groups_controller.rb" => "4da6c44467e108fe6d2df53a8aedc099"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])
    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{Gem::Specification.find_by_name(item[:package]).gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
