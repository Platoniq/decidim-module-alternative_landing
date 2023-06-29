# frozen_string_literal: true

require "spec_helper"

describe "Visit the home page", type: :system, perform_enqueued: true do
  let(:organization) { create :organization, available_locales: [:en] }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it "renders the home page" do
    expect(page).to have_content("Home")
  end

  context "when there are active alternative landing content blocks" do
    let!(:cover_full_block) { create(:cover_full_block, organization: organization) }
    let!(:cover_half_block) { create(:cover_half_block, organization: organization) }
    let!(:stack_horizontal_block) { create(:stack_horizontal_block, organization: organization) }
    let!(:stack_vertical_block) { create(:stack_vertical_block, organization: organization) }
    let!(:tiles_block) { create(:tiles_block, organization: organization) }
    let!(:latest_blog_posts_block) { create(:latest_blog_posts_block, organization: organization) }
    let!(:alternative_upcoming_meetings_block) { create(:alternative_upcoming_meetings_block, organization: organization) }
    let!(:blogs_component) { create(:component, manifest_name: "blogs", organization: organization) }
    let!(:meetings_component) { create(:component, manifest_name: "meetings", organization: organization) }
    let!(:blog_posts) { create_list(:post, 6, component: blogs_component) }
    let!(:meetings) { create_list(:meeting, 6, :upcoming, component: meetings_component) }
    let!(:sorted_meetings) { meetings.sort_by(&:start_time).reverse }

    before do
      visit decidim.root_path
    end

    it "renders them" do
      expect(page).to have_selector(".alternative-landing")
      expect(page).to have_selector(".alternative-landing.cover-full")
      expect(page).to have_selector(".alternative-landing.cover-half")
      expect(page).to have_selector(".alternative-landing.stack-horizontal")
      expect(page).to have_selector(".alternative-landing.stack-vertical")
      expect(page).to have_selector(".alternative-landing.tiles-4")
      expect(page).to have_selector(".alternative-landing.latest-blog-posts")
      expect(page).to have_selector(".alternative-landing.upcoming-meetings")
    end

    describe "cover blocks" do
      context "with cover half block" do
        it_behaves_like "render all cover block elements", "cover-half"
      end

      context "with cover full block" do
        it_behaves_like "render all cover block elements", "cover-full"
      end
    end

    describe "stack blocks" do
      context "with stack horizontal block" do
        it_behaves_like "render all stack block elements", "stack-horizontal"
      end

      context "with stack vertical block" do
        it_behaves_like "render all stack block elements", "stack-vertical"
      end
    end

    describe "tiles block" do
      it_behaves_like "render tiles block elements"
    end

    describe "latest_blog_posts block" do
      it "renders all elements" do
        within ".alternative-landing.latest-blog-posts" do
          expect(page).to have_i18n_content(latest_blog_posts_block.settings.title, upcase: true)
          expect(page).to have_i18n_content(latest_blog_posts_block.settings.link_text, upcase: true)
          blog_posts.last(3).each do |blog_post|
            expect(page).to have_i18n_content(blog_post.title)
          end
          blog_posts.first(3).each do |blog_post|
            expect(page).not_to have_i18n_content(blog_post.title)
          end
        end
      end
    end

    describe "alternative_upcoming_meetings block" do
      it "renders all elements" do
        within ".alternative-landing.upcoming-meetings" do
          expect(page).to have_i18n_content(alternative_upcoming_meetings_block.settings.title, upcase: true)
          expect(page).to have_i18n_content(alternative_upcoming_meetings_block.settings.link_text, upcase: true)
          sorted_meetings.last(3).each do |meeting|
            expect(page).to have_i18n_content(meeting.title)
          end
          sorted_meetings.first(3).each do |meeting|
            expect(page).not_to have_i18n_content(meeting.title)
          end
        end
      end
    end
  end
end
