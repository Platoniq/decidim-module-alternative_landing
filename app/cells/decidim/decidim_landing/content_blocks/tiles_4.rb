# frozen_string_literal: true

module Decidim
  module DecidimLanding
    module ContentBlocks
      class Tiles4Cell < Decidim::ViewModel
        def translated_title(x)
          return translated_attribute(model.settings.title) unless x
          translated_attribute(model.settings.send("title_#{x}"))
        end

        def translated_body(x)
          translated_attribute(model.settings.send("body_#{x}"))
        end

        def translated_link(x, classes="")
          link_to translated_attribute(model.settings.send("link_text_#{x}")), translated_attribute(model.settings.send("link_url_#{x}")), class: classes
        end

        def background_image(x)
          model.images_container.send("background_image_#{x}").big.url
        end
      end
    end
  end
end
