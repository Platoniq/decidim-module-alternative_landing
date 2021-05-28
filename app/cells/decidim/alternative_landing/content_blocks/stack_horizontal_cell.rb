# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class StackHorizontalCell < BaseCell
        def translated_title
          translated_attribute(model.settings.title)
        end

        def translated_body(x)
          translated_attribute(model.settings.send("body_#{x}"))
        end

        def translated_link(x, classes: "")
          link_to translated_attribute(model.settings.send("link_text_#{x}")), translated_attribute(model.settings.send("link_url_#{x}")), class: classes
        end

        def image(x)
          model.images_container.send("image_#{x}").big.url
        end
      end
    end
  end
end
