# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class StackVerticalCell < BaseCell
        def translated_title
          translated_attribute(model.settings.title)
        end

        def translated_body(item_number)
          translated_attribute(model.settings.send("body_#{item_number}"))
        end

        def translated_link(item_number, classes: "")
          link_to translated_attribute(model.settings.send("link_text_#{item_number}")), translated_attribute(model.settings.send("link_url_#{item_number}")), class: classes
        end

        def translated_tag(item_number, classes: "")
          link_to translated_attribute(model.settings.send("tag_text_#{item_number}")), translated_attribute(model.settings.send("tag_url_#{item_number}")), class: classes
        end

        def image(item_number)
          model.images_container.attached_uploader("image_#{item_number}".to_sym).path(variant: :square)
        end
      end
    end
  end
end
