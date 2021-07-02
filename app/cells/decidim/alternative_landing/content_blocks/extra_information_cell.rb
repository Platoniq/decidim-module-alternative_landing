# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class ExtraInformationCell < BaseCell
        def translated_body
          translated_attribute(model.settings.body)
        end

        def columns
          model.settings.columns
        end
      end
    end
  end
end
