# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class BaseCell < Decidim::ViewModel
        include Decidim::SanitizeHelper
        include Decidim::TranslationsHelper
        include Decidim::NeedsSnippets

        def show
          snippets.add(:head, stylesheet_link_tag("decidim/alternative_landing/application"))
          super
        end
      end
    end
  end
end
