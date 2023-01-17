# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class SelectedConsultationsSettingsFormCell < BaseCell
        alias form model

        def available_consultations
          Decidim::Consultation.published.where(organization: current_organization).map do |consultation|
            [translated_attribute(consultation.title), consultation.id]
          end
        end
      end
    end
  end
end
