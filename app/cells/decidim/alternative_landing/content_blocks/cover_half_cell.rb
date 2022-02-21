# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class CoverHalfCell < BaseCell
        def translated_title
          translated_attribute(model.settings.title)
         end

        def translated_body
          translated_attribute(model.settings.body)
        end

        def translated_link(classes: "")
          link_to translated_attribute(model.settings.link_text), translated_attribute(model.settings.link_url), class: classes
        end

        def background_image
          model.images_container.background_image.big.url
        end
      end
    end
  end
end
