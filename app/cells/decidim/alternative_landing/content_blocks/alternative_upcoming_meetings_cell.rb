# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      # A cell to be rendered as a content block with the upcoming meetings published
      # in a Decidim Organization.
      class AlternativeUpcomingMeetingsCell < BaseCell
        include Decidim::Core::Engine.routes.url_helpers
        include Decidim::Meetings::Engine.routes.url_helpers
        include Decidim::ApplicationHelper
        include Decidim::IconHelper

        def show
          return if meetings.empty?

          render
        end

        def meeting_path(meeting)
          Decidim::EngineRouter.main_proxy(meeting.component).meeting_path(meeting)
        end

        def meetings
          @meetings ||= Meetings::Meeting.upcoming.where(
            component: component || components
          ).limit(meetings_to_show).order(start_time: :asc)
        end

        private

        def manifest_name
          "meetings"
        end

        # A MD5 hash of model attributes because is needed because
        # it ensures the cache version value will always be the same size
        def cache_hash
          hash = []
          hash << "decidim/content_blocks/upcoming_meetings"
          hash << Digest::MD5.hexdigest(meetings.map(&:cache_key_with_version).to_s)
          hash << I18n.locale.to_s

          hash.join("/")
        end

        def meetings_to_show
          model.settings.count || 3
        end

        def section_title
          translated_attribute(model.settings.title).presence || t(".title")
        end

        def section_link
          link_to translated_attribute(model.settings.link_url) do
            translated_attribute(model.settings.link_text)
          end
        end
      end
    end
  end
end
