# frozen_string_literal: true

require "spec_helper"

describe "Visit the home page", :perform_enqueued do
  let(:organization) { create(:organization, available_locales: [:en]) }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it "renders the home page" do
    expect(page).to have_content("Home")
  end

  context "when there are active alternative landing content blocks" do
    let!(:cover_full_block) { create(:cover_full_block, organization:) }
    let!(:cover_half_block) { create(:cover_half_block, organization:) }
    let!(:stack_horizontal_block) { create(:stack_horizontal_block, organization:) }
    let!(:stack_vertical_block) { create(:stack_vertical_block, organization:) }
    let!(:tiles_block) { create(:tiles_block, organization:) }
    let!(:latest_blog_posts_block) { create(:latest_blog_posts_block, organization:) }
    let!(:alternative_upcoming_meetings_block) { create(:alternative_upcoming_meetings_block, organization:, component_id: meetings_component.id) }
    let!(:blogs_component) { create(:component, manifest_name: "blogs", organization:) }
    let!(:meetings_component) { create(:component, manifest_name: "meetings", organization:) }
    let!(:blog_posts) { create_list(:post, 6, component: blogs_component) }
    let!(:meetings) { create_list(:meeting, 6, :upcoming, component: meetings_component) }
    let!(:sorted_meetings) { meetings.sort_by(&:start_time).reverse }

    before do
      visit decidim.root_path
    end

    it "renders them" do
      expect(page).to have_css(".alternative-landing")
      expect(page).to have_css(".alternative-landing.cover-full")
      expect(page).to have_css(".cover-half")
      expect(page).to have_css(".stack-horizontal")
      expect(page).to have_css(".stack-vertical")
      expect(page).to have_css(".alternative-landing.tiles-4")
      expect(page).to have_css(".latest-blog-posts")
      expect(page).to have_css(".alternative-landing.upcoming-meetings")
    end

    describe "cover blocks" do
      it_behaves_like "render all cover block elements", "cover-half"
      it_behaves_like "render all cover block elements", "cover-full"
    end

    describe "stack blocks" do
      it_behaves_like "render all stack block elements", "stack-horizontal"
      it_behaves_like "render all stack block elements", "stack-vertical"

      context "without images" do
        before do
          stack_horizontal_block.attachments.destroy_all
          stack_vertical_block.attachments.destroy_all
        end

        it_behaves_like "render all stack block elements", "stack-horizontal"
        it_behaves_like "render all stack block elements", "stack-vertical"
      end
    end

    describe "tiles block" do
      it_behaves_like "render tiles block elements"

      context "with link" do
        before do
          settings = tiles_block.settings
          settings.link_url_1 = Decidim::Faker::Localized.literal(Faker::Internet.url)
          tiles_block.settings = settings
          tiles_block.save
        end

        it_behaves_like "render tiles block elements"
      end
    end

    describe "latest_blog_posts block" do
      it "renders all elements" do
        within ".latest-blog-posts" do
          expect(page).to have_i18n_content(latest_blog_posts_block.settings.title)
          expect(page).to have_i18n_content(latest_blog_posts_block.settings.link_text)
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
          expect(page).to have_i18n_content(alternative_upcoming_meetings_block.settings.title)
          expect(page).to have_i18n_content(alternative_upcoming_meetings_block.settings.link_text)
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
