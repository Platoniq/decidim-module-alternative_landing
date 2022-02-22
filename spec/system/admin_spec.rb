# frozen_string_literal: true

require "spec_helper"

describe "Admin manages organization homepage", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  let!(:cover_full_block) { create :cover_full_block, organization: organization }
  let!(:cover_half_block) { create :cover_half_block, organization: organization }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.edit_organization_homepage_path
  end

  context "when editing a cover_full content block" do
    before do
      visit decidim_admin.edit_organization_homepage_content_block_path(:cover_full)
    end

    it "updates the settings of the content block" do
      fill_in(
        :content_block_settings_title_en,
        with: "Custom welcome text!"
      )
      click_button "Update"
      visit decidim.root_path
      expect(page).to have_content("Custom welcome text!"
    end

    it "updates the images of the content block" do
      attach_file(
        :content_block_images_background_image,
        Decidim::Dev.asset("city2.jpeg")
      )

      click_button "Update"
      visit decidim.root_path
      expect(page.html).to include("city2.jpeg")
    end
  end

  context "when editing a cover_half content block" do
    before do
      visit decidim_admin.edit_organization_homepage_content_block_path(:cover_half)
    end

    it "updates the settings of the content block" do
      fill_in(
        :content_block_settings_title_en,
        with: "Hello there people!"
      )
      click_button "Update"
      visit decidim.root_path
      expect(page).to have_content("Hello there people!")
    end

    it "updates the images of the content block" do
      attach_file(
        :content_block_images_background_image,
        Decidim::Dev.asset("city3.jpeg")
      )

      click_button "Update"
      visit decidim.root_path
      expect(page.html).to include("city3.jpeg")
    end
  end
end
