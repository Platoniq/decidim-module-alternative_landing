# frozen_string_literal: true

require "spec_helper"

describe "Visit the home page", :perform_enqueued do
  let(:organization) { create(:organization, available_locales: [:en]) }

  before do
    switch_to_host(organization.host)
  end

  context "when there is an active 'latest_blog_posts' content block" do
    let(:settings) do
      {
        title: Decidim::Faker::Localized.sentence,
        link_text: Decidim::Faker::Localized.sentence,
        link_url: { en: "https://url-en.org" }
      }
    end
    let!(:latest_blog_posts_block) { create(:latest_blog_posts_block, organization:, settings:) }
    let!(:blogs_component) { create(:component, manifest_name: "blogs", organization:) }
    let!(:blog_posts) { create_list(:post, 6, component: blogs_component) }

    describe "latest_blog_posts block" do
      before do
        visit decidim.root_path
      end

      it "renders it" do
        expect(page).to have_css(".latest-blog-posts")
      end

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

      context "when 'component_id' option is set" do
        let(:settings) { { component_id: blogs_component.id } }
        let!(:other_blogs_component) { create(:component, manifest_name: "blogs", organization:) }
        let!(:other_blog_posts) { create_list(:post, 6, component: other_blogs_component) }

        it "renders only posts from that component" do
          within ".latest-blog-posts" do
            other_blog_posts.each do |blog_post|
              expect(page).not_to have_i18n_content(blog_post.title)
            end
          end
        end
      end
    end
  end
end
