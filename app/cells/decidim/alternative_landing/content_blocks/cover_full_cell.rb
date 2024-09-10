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
          model.images_container.attached_uploader(:background_image).path(variant: :big)
        end

        def id_type
          process_group_url = "processes_groups"
          request.url.include?(process_group_url) ? "hero-1" : ""
        end
      end
    end
  end
end
