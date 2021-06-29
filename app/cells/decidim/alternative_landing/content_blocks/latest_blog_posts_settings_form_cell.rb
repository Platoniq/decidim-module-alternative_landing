# frozen_string_literal: true

module Decidim
  module AlternativeLanding
    module ContentBlocks
      class LatestBlogPostsSettingsFormCell < Decidim::ViewModel
        alias form model

        def blog
          @blog ||= Decidim::Component.find_by(id: form.object.settings.try(:blog_id))
        end

        def available_blogs
          Decidim::Component.where(participatory_space: participatory_spaces, manifest_name: "blogs").map do |blog|
            ["#{translated_attribute(blog.name)} (#{translated_attribute(blog.participatory_space.title)})", blog.id]
          end
        end

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
      end
    end
  end
end