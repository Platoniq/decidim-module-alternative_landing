# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class BaseCell < Decidim::ViewModel
        include Decidim::SanitizeHelper
        include Decidim::TranslationsHelper

        delegate :snippets, to: :controller

        def show
          snippets.add(:alternative_landing, stylesheet_link_tag("decidim/alternative_landing/application"))
          super
        end
      end
    end
  end
end
