# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    class CalendarEventPresenter < SimpleDelegator
      EVENT_TYPE_COLORS = {
        debate: "var(--primary)",
        election: "var(--warning)",
        meeting: "var(--success)",
        participatory_process_step: "var(--secondary)",
        survey: "var(--alert)"
      }.freeze

      def type
        __getobj__.class.name.demodulize.underscore
      end

      def color
        EVENT_TYPE_COLORS[type.to_sym]
      end

      def full_id
        case type
        when "participatory_process_step"
          "#{participatory_process.id}-#{id}"
        else
          id
        end
      end

      def parent
        case type
        when "participatory_process_step"
          "#{participatory_process.id}-#{participatory_process.steps.find_by(position: position - 1).id}" if position.positive?
        end
      end

      def link
        return url if respond_to?(:url)

        @link ||= case type
                  when "participatory_process_step"
                    Decidim::ResourceLocatorPresenter.new(participatory_process).url
                  when "survey"
                    # surveys aren't registered as resources, probably a bug in Decidim?
                    Decidim::EngineRouter.main_proxy(__getobj__.component).root_path
                  else
                    Decidim::ResourceLocatorPresenter.new(__getobj__).url
                  end
      end

      def start
        @start ||= if respond_to?(:start_date)
                     start_date
                   elsif respond_to?(:start_at)
                     start_at
                   elsif respond_to?(:starts_at)
                     starts_at
                   elsif respond_to?(:start_voting_date)
                     start_voting_date
                   else
                     start_time
                   end
      end

      def finish
        @finish ||= if respond_to?(:end_date)
                      end_date
                    elsif respond_to?(:end_at)
                      end_at
                    elsif respond_to?(:ends_at)
                      ends_at
                    elsif respond_to?(:end_voting_date)
                      end_voting_date
                    else
                      end_time
                    end
        @finish || start
      end

      def full_title
        @full_title ||= case type
                        when "participatory_process_step"
                          participatory_process.title
                        when "survey"
                          questionnaire.title
                        else
                          title
                        end
      end

      def subtitle
        @subtitle ||= case type
                      when "participatory_process_step"
                        title
                      else
                        ""
                      end
      end

      def all_day?
        return false if start.nil? || finish.nil?

        (start.to_date..finish.to_date).count > 1
      end
    end
  end
end
