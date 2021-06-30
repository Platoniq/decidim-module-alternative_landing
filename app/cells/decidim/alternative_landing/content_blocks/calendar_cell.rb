# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class CalendarCell < BaseCell
        def participatory_process_group
          @participatory_process_group ||= Decidim::ParticipatoryProcessGroup.find(model.scoped_resource_id)
        end

        def resources
          @resources ||= models.map { |m| m.name.demodulize.underscore }
        end

        def render_events
          events.map do |event|
            {
              title: translated_attribute(event.full_title),
              start: (event.start.strftime("%FT%R") unless event.start.nil?),
              end: (event.finish.strftime("%FT%R") unless event.finish.nil?),
              color: event.color,
              url: event.link,
              resourceId: event.type,
              allDay: event.all_day?,
              subtitle: (translated_attribute(event.subtitle) unless event.subtitle.empty?)
            }.compact
          end.to_json
        end

        private

        def participatory_processes
          Decidim::ParticipatoryProcess.where(participatory_process_group: participatory_process_group)
        end

        def components
          Decidim::Component.where(participatory_space: participatory_processes)
        end

        def events
          @events = []
          models.map do |model|
            model
              .where(model.attribute_names.include?("decidim_component_id") ? { component: components } : { decidim_participatory_process_id: participatory_processes.pluck(:id) })
              .map { |obj| @events << present(obj) if obj.organization == current_organization && present(obj).start }
          end
          @events
        end

        def models
          @models ||= [
            Decidim::Debates::Debate.where(component: components),
            Decidim::Meetings::Meeting,
            Decidim::Surveys::Survey,
            Decidim::ParticipatoryProcessStep,
            (Decidim::Elections::Election if defined? Decidim::Elections)
          ].compact
        end

        def present(obj)
          Decidim::AlternativeLanding::CalendarEventPresenter.new(obj)
        end
      end
    end
  end
end
