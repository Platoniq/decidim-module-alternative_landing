# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class ExtraTitleCell < Decidim::ParticipatoryProcessGroups::ContentBlocks::TitleCell
        def links
          1.upto(5).to_a.map do |item_number|
            link(item_number) if link_text(item_number).present?
          end.compact
        end

        private

        def link(item_number)
          safe_join(
            [
              link_icon(item_number),
              link_to(link_text(item_number), link_url(item_number), target: :blank)
            ]
          )
        end

        def link_text(item_number)
          translated_attribute(model.settings.send("link_text_#{item_number}"))
        end

        def link_url(item_number)
          model.settings.send("link_url_#{item_number}")
        end

        def link_icon(item_number)
          icon(model.settings.send("link_icon_name_#{item_number}"), class: "mr-xs")
        end
      end
    end
  end
end
