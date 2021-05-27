# frozen_string_literal: true

module Decidim
  module DecidimLanding
    module ContentBlocks
      class CoverFullCell < Decidim::ViewModel
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
