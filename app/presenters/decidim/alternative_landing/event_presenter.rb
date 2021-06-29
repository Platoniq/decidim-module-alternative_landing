# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    class EventPresenter < SimpleDelegator
      def color
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "var(--secondary)"
        when "Decidim::Meetings::Meeting"
          "var(--success)"
        when "Decidim::Debates::Debate"
          "var(--primary)"
        when "Decidim::Consultation"
          "var(--warning)"
        end
      end

      def type
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "participatory_step"
        when "Decidim::Meetings::Meeting"
          "meeting"
        when "Decidim::Debates::Debate"
          "debate"
        when "Decidim::Consultation"
          "consultation"
        end
      end

      def full_id
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "#{participatory_process.id}-#{id}"
        else
          id
        end
      end

      def parent
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "#{participatory_process.id}-#{participatory_process.steps.find_by(position: position - 1).id}" if position.positive?
        end
      end

      def link
        return url if respond_to?(:url)

        @link ||= case __getobj__.class.name
                  when "Decidim::ParticipatoryProcessStep"
                    Decidim::ResourceLocatorPresenter.new(participatory_process).url
                  else
                    Decidim::ResourceLocatorPresenter.new(__getobj__).url
                  end
      end

      def start
        @start ||= if respond_to?(:start_date)
                     start_date
                   elsif respond_to?(:start_at)
                     start_at
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
                    elsif respond_to?(:end_voting_date)
                      end_voting_date
                    else
                      end_time
                    end
        @finish || start
      end

      def full_title
        @full_title ||= case __getobj__.class.name
                        when "Decidim::ParticipatoryProcessStep"
                          participatory_process.title
                        else
                          title
                        end
      end

      def subtitle
        @subtitle ||= case __getobj__.class.name
                      when "Decidim::ParticipatoryProcessStep"
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
