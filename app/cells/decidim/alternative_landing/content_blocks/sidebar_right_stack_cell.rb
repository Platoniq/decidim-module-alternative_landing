# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class SidebarRightStackCell < BaseCell
        def translated_title(section)
          translated_attribute(model.settings.send("title_#{section}"))
        end

        def translated_body
          translated_attribute(model.settings.body)
        end

        def translated_link_text(section)
          translated_attribute(model.settings.send("link_text_#{section}"))
        end

        def translated_url(section)
          translated_attribute(model.settings.send("link_url_#{section}"))
        end

        def background_image
          model.images_container.attached_uploader(:background_image).path(variant: :big)
        end

        def meetings
          @meetings ||= Meetings::Meeting.upcoming.where(
            component: component || components
          )
        end

        def posts
          @posts ||= Blogs::Post.where(
            component: component || components
          ).order(created_at: :desc)
        end
      end
    end
  end
end
