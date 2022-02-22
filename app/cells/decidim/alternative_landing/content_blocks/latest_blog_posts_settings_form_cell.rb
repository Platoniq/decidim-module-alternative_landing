# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class LatestBlogPostsSettingsFormCell < BaseCell
        alias form model

        def manifest_name
          "blogs"
        end
      end
    end
  end
end
