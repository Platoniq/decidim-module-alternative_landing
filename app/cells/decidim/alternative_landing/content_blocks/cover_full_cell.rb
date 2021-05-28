# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class CoverFullCell < BaseCell
        def translated_title
          translated_attribute(model.settings.title)
        end

        def translated_body
          translated_attribute(model.settings.body)
        end

        def background_image
          model.images_container.background_image.big.url
        end
      end
    end
  end
end
