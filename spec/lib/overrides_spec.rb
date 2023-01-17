# frozen_string_literal: true

require "spec_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/homepage_controller.rb" => "32b76eccc946735d60a4ae9244137bb2"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/cells/decidim/participatory_process_groups/content_blocks/title_cell.rb" => "65d3f0094c1e57f8ae48e171c1f83b7e",
      "/app/cells/decidim/participatory_process_groups/content_blocks/title/show.erb" => "de6115a71971e8394b8cb95097c37aa9",
      "/app/controllers/decidim/participatory_processes/participatory_process_groups_controller.rb" => "dfcb6e08afd32f34b43a5caa93281973"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    # rubocop:disable Rails/DynamicFindBy
    spec = ::Gem::Specification.find_by_name(item[:package])
    # rubocop:enable Rails/DynamicFindBy
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
