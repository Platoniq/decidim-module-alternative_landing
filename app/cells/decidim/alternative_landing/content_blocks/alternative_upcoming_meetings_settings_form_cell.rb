# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class AlternativeUpcomingMeetingsSettingsFormCell < BaseCell
        alias form model

        def component
          @component ||= Decidim::Component.find_by(id: form.object.settings.try(:component_id))
        end
      end
    end
  end
end
