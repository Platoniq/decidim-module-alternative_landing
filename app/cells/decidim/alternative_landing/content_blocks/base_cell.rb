# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class BaseCell < Decidim::ViewModel
        include Decidim::SanitizeHelper
        include Decidim::TranslationsHelper
      end
    end
  end
end
