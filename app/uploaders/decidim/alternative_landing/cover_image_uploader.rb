# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    # This class deals with uploading cover images to content blocks.
    class CoverImageUploader < RecordImageUploader
      set_variants do
        {
          big: { resize_to_fit: [2880, 1620] }
        }
      end
    end
  end
end
