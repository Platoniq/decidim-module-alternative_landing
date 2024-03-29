# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      # A cell to be rendered as a content block with the latest blog posts published
      # in a Decidim Organization.
      class LatestBlogPostsCell < BaseCell
        include Decidim::Core::Engine.routes.url_helpers
        include Decidim::Blogs::PostsHelper

        def show
          return if posts.empty?

          render
        end

        def post_path(post)
          Decidim::EngineRouter.main_proxy(post.component).post_path(post)
        end

        def posts
          @posts ||= Blogs::Post.where(
            component: component || components
          ).limit(posts_to_show).order(created_at: :desc)
        end

        private

        def manifest_name
          "blogs"
        end

        # A MD5 hash of model attributes because is needed because
        # it ensures the cache version value will always be the same size
        def cache_hash
          hash = []
          hash << "decidim/content_blocks/latest_blog_posts"
          hash << Digest::MD5.hexdigest(posts.map(&:cache_key_with_version).to_s)
          hash << "#{section_title}/#{section_link}"
          hash << I18n.locale.to_s

          hash.join("/")
        end

        def posts_to_show
          model.settings.count || 3
        end

        def section_title
          translated_attribute(model.settings.title).presence || t(".title")
        end

        def section_link
          link_to translated_attribute(model.settings.link_url) do
            translated_attribute(model.settings.link_text)
          end
        end
      end
    end
  end
end
