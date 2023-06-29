# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class AlternativeUpcomingMeetingsSettingsFormCell < BaseCell
        alias form model

        def manifest_name
          "meetings"
        end
      end
    end
  end
end
