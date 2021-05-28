# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class TilesCell < BaseCell
        def translated_title(x = nil)
          return translated_attribute(model.settings.title) unless x

          translated_attribute(model.settings.send("title_#{x}"))
        end

        def translated_body(x)
          translated_attribute(model.settings.send("body_#{x}"))
        end

        def background_image(x)
          model.images_container.send("background_image_#{x}").big.url
        end
      end
    end
  end
end
