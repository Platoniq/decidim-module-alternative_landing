# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module DefaultOpacities
      class << self
        def cover_full
          {
            background_text: 0.7,
            background_image: 1,
            text: 1,
            navbar: 0.3
          }
        end

        def cover_half
          {
            background_text: 0.7,
            background_image: 1,
            text: 1,
            navbar: 0.3
          }
        end
      end
    end
  end
end
