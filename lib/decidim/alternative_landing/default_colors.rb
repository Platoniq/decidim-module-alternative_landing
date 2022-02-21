module Decidim
  module AlternativeLanding
    module DefaultColors
      class << self
        def cover_full
          {
            background_text: "var(--secondary)",
            background_image: "var(--secondary)",
            text: "#ffffff",
            navbar: "#000000"
          }
        end

        def cover_half
          {
            background_text: "var(--primary)",
            background_image: "var(--primary)",
            text: "#ffffff",
            navbar: "#000000"
          }
        end
      end
    end
  end
end
