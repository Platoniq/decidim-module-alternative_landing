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

        def available_components
          @available_components ||= components.where(manifest_name:).map do |component|
            ["#{translated_attribute(component.name)} (#{translated_attribute(component.participatory_space.title)})", component.id]
          end.unshift [t(".all"), nil]
        end

        def component
          @component ||= components.find_by(id: (defined?(form) ? form.object : model).settings.try(:component_id))
        end

        def components
          @components ||= Decidim::Component.where(participatory_space: participatory_spaces)
        end

        def manifest_name
          raise NotImplementedError
        end

        def colors
          model.settings.to_h.select { |k, _v| k.match?(/color_/) }
        end

        def opacities
          model.settings.to_h.select { |k, _v| k.match?(/opacity_/) }
        end

        def color_keys
          form.object.settings.to_h.keys.grep(/color_/)
        end

        def opacity_keys
          form.object.settings.to_h.keys.grep(/opacity_/)
        end

        # Renders a view with the customizable CSS variables in two flavours:
        # 1. as a hexadecimal valid CSS color (ie: #ff0000)
        # 2. as a disassembled RGB components (ie: 255,0,0)
        #
        # Example:
        #
        # --primary: #ff0000;
        # --primary-rgb: 255,0,0
        #
        # Hexadecimal variables can be used as a normal CSS color:
        #
        # color: var(--primary)
        #
        # While the disassembled variant can be used where you need to manipulate
        # the color somehow (ie: adding a background transparency):
        #
        # background-color: rgba(var(--primary-rgb), 0.5)
        def css
          colors_css + opacities_css
        end

        private

        def colors_css
          colors.each.map do |k, v|
            if v.match?(/^#[0-9a-fA-F]{6}$/)
              "--#{k}: #{v};--#{k}-rgb: #{v[1..2].hex},#{v[3..4].hex},#{v[5..6].hex};"
            else
              "--#{k}: #{v};"
            end
          end.join
        end

        def opacities_css
          opacities.each.map do |k, v|
            "--#{k}: #{v};"
          end.join
        end
      end
    end
  end
end
