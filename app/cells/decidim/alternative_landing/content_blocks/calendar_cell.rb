# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class CalendarCell < BaseCell
        def events
          @events = []
          models.map do |model|
            model
              .all
              .map { |obj| @events << present(obj) if obj.organization == current_organization && present(obj).start }
          end
          @events
        end

        def resources
          @resources ||= %w(debate meeting participatory_step)
          @resources = @resources << "consultation" if defined? Decidim::Consultation
          @resources
        end

        def models
          @models ||= [
            Decidim::Meetings::Meeting,
            Decidim::ParticipatoryProcessStep,
            Decidim::Debates::Debate,
            (Decidim::Consultation if defined? Decidim::Consultation)
          ].compact
        end

        def present(obj)
          Decidim::AlternativeLanding::EventPresenter.new(obj)
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
      end
    end
  end
end
