# frozen_string_literal: true

require "spec_helper"
require "shared/system_admin_homepage_examples"

describe "Admin visits homepage settings", type: :system do
  include ActionView::Helpers::SanitizeHelper

  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }
  let(:blogs_component) { create(:component, manifest_name: "blogs", organization: organization) }
  let(:meetings_component) { create(:component, manifest_name: "meetings", organization: organization) }
  let!(:post) { create(:post, component: blogs_component) }
  let!(:meeting) { create :meeting, component: meetings_component }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  context "when visiting homepage settings" do
    before do
      visit decidim_admin.edit_organization_homepage_path
    end

    it "renders active and inactive content blocks headers" do
      expect(page).to have_content("Active content blocks")
      expect(page).to have_content("Inactive content blocks")
    end

    it "renders all alternative landing content blocks" do
      expect(page).to have_content("Upcoming meetings (Alternative)")
      expect(page).to have_content("Stack of 3 custom items (Horizontal)")
      expect(page).to have_content("Stack of 3 custom items (Vertical)")
      expect(page).to have_content("Latest blog posts")
      expect(page).to have_content("Cover (Full screen)")
      expect(page).to have_content("Cover (Half screen)")
      expect(page).to have_content("Tiles")
    end

    it "has initial active content blocks equal to 0" do
      expect(Decidim::ContentBlock.count).to eq 0
    end

    context "when dragging the content block from inactive to active panel" do
      it_behaves_like "increase number of content blocks", "Upcoming meetings (Alternative)"
      it_behaves_like "increase number of content blocks", "Stack of 3 custom items (Horizontal)"
      it_behaves_like "increase number of content blocks", "Stack of 3 custom items (Vertical)"
      it_behaves_like "increase number of content blocks", "Latest blog posts"
      it_behaves_like "increase number of content blocks", "Cover (Full screen)"
      it_behaves_like "increase number of content blocks", "Cover (Half screen)"
      it_behaves_like "increase number of content blocks", "Tiles"
    end

    context "when editing a persisted content block" do
      let!(:alternative_upcoming_meetings_block) { create :alternative_upcoming_meetings_block, organization: organization, scope_name: :homepage, component_id: meetings_component.id }
      let!(:cover_full_block) { create :content_block, organization: organization, manifest_name: "cover_full", scope_name: :homepage }
      let!(:cover_half_block) { create :cover_half_block, organization: organization, scope_name: :homepage }
      let!(:latest_blog_posts_block) { create :latest_blog_posts_block, organization: organization, scope_name: :homepage, component_id: blogs_component.id }
      let!(:stack_horizontal_block) { create :stack_horizontal_block, organization: organization, scope_name: :homepage }
      let!(:stack_vertical_block) { create :stack_vertical_block, organization: organization, scope_name: :homepage }
      let!(:tiles_block) { create :tiles_block, organization: organization, scope_name: :homepage }

      it_behaves_like "updates the content block", "alternative_upcoming_meetings"
      it_behaves_like "updates the content block", "cover_full"
      it_behaves_like "updates the content block", "cover_half"
      it_behaves_like "updates the content block", "latest_blog_posts"
      it_behaves_like "updates the content block", "stack_horizontal"
      it_behaves_like "updates the content block", "stack_vertical"
      it_behaves_like "updates the content block", "tiles"

      it "updates the images of the content block" do
        visit decidim_admin.edit_organization_homepage_content_block_path(:cover_full)

        dynamically_attach_file(:content_block_images_background_image, Decidim::Dev.asset("city2.jpeg"))

        click_button "Update"
        visit decidim.root_path
        expect(page.html).to include("city2.jpeg")
      end
    end
  end
end
