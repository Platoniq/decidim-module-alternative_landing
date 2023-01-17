# frozen_string_literal: true

def initialize_homepage_content_blocks
  initializer "decidim_alternative_landing.content_blocks" do
    Decidim.content_blocks.register(:homepage, :alternative_upcoming_meetings) do |content_block|
      content_block.cell = "decidim/alternative_landing/content_blocks/alternative_upcoming_meetings"
      content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/alternative_upcoming_meetings_settings_form"
      content_block.public_name_key = "decidim.alternative_landing.content_blocks.alternative_upcoming_meetings.name"

      content_block.settings do |settings|
        settings.attribute :title, type: :text, translated: true
        settings.attribute :link_text, type: :text, translated: true
        settings.attribute :link_url, type: :text, translated: true
        settings.attribute :count, type: :integer, default: 3
        settings.attribute :component_id, type: :integer
      end
    end
  end
end
