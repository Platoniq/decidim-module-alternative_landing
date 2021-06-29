# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    # This class deals with uploading cover images to content blocks.
    class CoverImageUploader < RecordImageUploader
      version :big do
        process resize_to_fit: [2880, 1620]
      end

      def max_image_height_or_width
        8000
      end
    end
  end
end
