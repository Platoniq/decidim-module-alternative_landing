# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class UpcomingMeetingsSettingsFormCell < BaseCell
        alias form model

        def manifest_name
          "meetings"
        end
      end
    end
  end
end
