# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class HighlightedConsultationsCell < BaseCell
        def show
          return unless defined? Decidim::Consultations

          render if highlighted_consultations.any?
        end

        def highlighted_consultations
          @highlighted_consultations ||= Decidim::Consultation.published.where(organization: current_organization, id: model.settings.consultations)
        end

        def decidim_consultations
          Decidim::Consultations::Engine.routes.url_helpers
        end

        def section_title
          translated_attribute(model.settings.title).presence || t(".title")
        end

        def button_text
          translated_attribute(model.settings.button_text).presence || t(".see_all")
        end
      end
    end
  end
end
