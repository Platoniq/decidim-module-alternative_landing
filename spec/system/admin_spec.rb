# frozen_string_literal: true

require "spec_helper"

describe "Admin manages organization homepage", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  context "when editing a cover_full content block" do
    let!(:cover_full_block) { create :cover_full_block, organization: organization }

    before do
      visit decidim_admin.edit_organization_homepage_content_block_path(cover_full_block.id)
    end

    it "updates the settings of the content block" do
      fill_in(
        :content_block_settings_title_en,
        with: "Custom welcome text!"
      )
      click_button "Update"
      visit decidim.root_path
      expect(page).to have_content("Custom welcome text!")
    end

    it "updates the images of the content block" do
      dynamically_attach_file(:content_block_images_background_image, Decidim::Dev.asset("city2.jpeg"), remove_before: true)

      click_button "Update"
      visit decidim.root_path
      expect(page.html).to include("city2.jpeg")
    end
  end

  context "when editing a cover_half content block" do
    let!(:cover_half_block) { create :cover_half_block, organization: organization }

    before do
      visit decidim_admin.edit_organization_homepage_content_block_path(cover_half_block.id)
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
      dynamically_attach_file(:content_block_images_background_image, Decidim::Dev.asset("city3.jpeg"), remove_before: true)

      click_button "Update"
      visit decidim.root_path
      expect(page.html).to include("city3.jpeg")
    end
  end

  context "when editing a latest_blog_posts content block" do
    let!(:latest_blog_posts_block) { create(:latest_blog_posts_block, organization: organization) }
    let!(:blogs_component) { create(:component, manifest_name: "blogs", organization: organization) }
    let!(:other_blogs_component) { create(:component, manifest_name: "blogs", organization: organization) }
    let!(:other_organization_blogs_component) { create(:component, manifest_name: "blogs") }
    let!(:blog_posts) { create_list(:post, 2, component: blogs_component) }
    let!(:other_blog_posts) { create_list(:post, 2, component: other_blogs_component) }
    let!(:other_organization_blog_posts) { create_list(:post, 2, component: other_organization_blogs_component) }

    before do
      visit decidim_admin.edit_organization_homepage_content_block_path(latest_blog_posts_block.id)
    end

    it "updates the settings of the content block" do
      fill_in :content_block_settings_title_en, with: "Latest blog posts"
      fill_in :content_block_settings_link_text_en, with: "See all"
      fill_in :content_block_settings_link_url_en, with: "example.org/example-path"
      fill_in :content_block_settings_count, with: 4

      click_button "Update"
      visit decidim.root_path

      within ".latest-blog-posts" do
        expect(page).to have_content "Latest blog posts"
        expect(page).to have_link "See all", href: "example.org/example-path"

        blog_posts.each do |blog_post|
          expect(page).to have_i18n_content(blog_post.title)
        end

        other_blog_posts.each do |blog_post|
          expect(page).to have_i18n_content(blog_post.title)
        end

        other_organization_blog_posts.each do |blog_post|
          expect(page).not_to have_i18n_content(blog_post.title)
        end
      end

      visit decidim_admin.edit_organization_homepage_content_block_path(latest_blog_posts_block.id)
      select blogs_component.name["en"], from: "Component"

      click_button "Update"
      visit decidim.root_path

      within ".latest-blog-posts" do
        blog_posts.each do |blog_post|
          expect(page).to have_i18n_content(blog_post.title)
        end

        other_blog_posts.each do |blog_post|
          expect(page).not_to have_i18n_content(blog_post.title)
        end

        other_organization_blog_posts.each do |blog_post|
          expect(page).not_to have_i18n_content(blog_post.title)
        end
      end
    end
  end

  context "when editing a upcoming_meetings content block" do
    let!(:alternative_upcoming_meetings_block) { create(:alternative_upcoming_meetings_block, organization: organization) }
    let!(:meetings_component) { create(:component, manifest_name: "meetings", organization: organization) }
    let!(:other_meetings_component) { create(:component, manifest_name: "meetings", organization: organization) }
    let!(:other_organization_meetings_component) { create(:component, manifest_name: "meetings") }
    let!(:meetings) { create_list(:meeting, 2, :upcoming, component: meetings_component) }
    let!(:other_meetings) { create_list(:meeting, 2, :upcoming, component: other_meetings_component) }
    let!(:other_organization_meetings) { create_list(:meeting, 2, :upcoming, component: other_organization_meetings_component) }

    before do
      visit decidim_admin.edit_organization_homepage_content_block_path(alternative_upcoming_meetings_block.id)
    end

    it "updates the settings of the content block" do
      fill_in :content_block_settings_title_en, with: "Upcoming meetings"
      fill_in :content_block_settings_link_text_en, with: "See all"
      fill_in :content_block_settings_link_url_en, with: "example.org/example-path"
      fill_in :content_block_settings_count, with: 4

      click_button "Update"
      visit decidim.root_path

      within ".alternative-landing.upcoming-meetings" do
        expect(page).to have_content "Upcoming meetings"
        expect(page).to have_link "See all", href: "example.org/example-path"

        meetings.each do |meeting|
          expect(page).to have_i18n_content(meeting.title)
        end

        other_meetings.each do |meeting|
          expect(page).to have_i18n_content(meeting.title)
        end

        other_organization_meetings.each do |meeting|
          expect(page).not_to have_i18n_content(meeting.title)
        end
      end

      visit decidim_admin.edit_organization_homepage_content_block_path(alternative_upcoming_meetings_block.id)
      select meetings_component.name["en"], from: "Component"

      click_button "Update"
      visit decidim.root_path

      within ".alternative-landing.upcoming-meetings" do
        meetings.each do |meeting|
          expect(page).to have_i18n_content(meeting.title)
        end

        other_meetings.each do |meeting|
          expect(page).not_to have_i18n_content(meeting.title)
        end

        other_organization_meetings.each do |meeting|
          expect(page).not_to have_i18n_content(meeting.title)
        end
      end
    end
  end
end
