# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class TilesCell < BaseCell
        def translated_title(item_number = nil)
          return translated_attribute(model.settings.title) if item_number.blank?

          if translated_url(item_number).blank?
            translated_attribute(model.settings.send("title_#{item_number}"))
          else
            link_to translated_attribute(model.settings.send("title_#{item_number}")), translated_url(item_number)
          end
        end

        def translated_body(item_number)
          translated_attribute(model.settings.send("body_#{item_number}"))
        end

        def translated_url(item_number)
          translated_attribute(model.settings.send("link_url_#{item_number}"))
        end

        def background_image(item_number)
          model.images_container.attached_uploader("background_image_#{item_number}".to_sym).path(variant: :landscape)
        end

        def id_type
          process_group_url = "processes_groups"
          request.url.include?(process_group_url) ? "hero-1" : ""
        end
      end
    end
  end
end
