# frozen_string_literal: true

module Decidim
  module ContentBlocks
    # A cell to be rendered as a content block with a background image and a translatable text
    # in a Decidim Organization.
    class HighlightedContentBannerAlternativeCell < Decidim::ViewModel
      def description
        decidim_sanitize(translated_attribute(model.settings.body))
      end

      def background_image
        model.images_container.background_image.big.url
      end
    end
  end
end
