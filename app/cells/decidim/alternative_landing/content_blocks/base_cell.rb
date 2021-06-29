# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class BaseCell < Decidim::ViewModel
        include Decidim::SanitizeHelper
        include Decidim::TranslationsHelper

        def participatory_spaces
          @participatory_spaces ||= [
            Decidim::Assembly.where(organization: current_organization),
            Decidim::ParticipatoryProcess.where(organization: current_organization),
            (Decidim::Conference.where(organization: current_organization) if defined? Decidim::Conference),
            (Decidim::Consultation.where(organization: current_organization) if defined? Decidim::Consultation),
            (Decidim::Election.where(organization: current_organization) if defined? Decidim::Election),
            (Decidim::Initiative.where(organization: current_organization) if defined? Decidim::Initiative)
          ].flatten.compact
        end

        def available_components(manifest_name)
          Decidim::Component.published.where(participatory_space: participatory_spaces, manifest_name: manifest_name).map do |component|
            ["#{translated_attribute(component.name)} (#{translated_attribute(component.participatory_space.title)})", component.id]
          end.unshift [t(".all"), nil]
        end

        def component
          @component ||= Decidim::Component.find_by(id: form.object.settings.try(:component_id))
        end
      end
    end
  end
end
