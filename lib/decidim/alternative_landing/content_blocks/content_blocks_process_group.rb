# frozen_string_literal: true

def initialize_process_group_content_blocks
  initializer "decidim_alternative_landing.content_blocks" do
    Decidim.content_blocks.register(:participatory_process_group_homepage, :extra_title) do |content_block|
      content_block.cell = "decidim/alternative_landing/content_blocks/extra_title"
      content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/extra_title_settings_form"
      content_block.public_name_key = "decidim.alternative_landing.content_blocks.extra_title.name"

      content_block.settings do |settings|
        1.upto(5) do |item_number|
          settings.attribute :"link_text_#{item_number}", type: :text, translated: true, editor: true
          settings.attribute :"link_url_#{item_number}", type: :text
          settings.attribute :"link_icon_name_#{item_number}", type: :text, default: "external-link"
        end
      end
    end

    Decidim.content_blocks.register(:participatory_process_group_homepage, :extra_information) do |content_block|
      content_block.cell = "decidim/alternative_landing/content_blocks/extra_information"
      content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/extra_information_settings_form"
      content_block.public_name_key = "decidim.alternative_landing.content_blocks.extra_information.name"

      content_block.settings do |settings|
        settings.attribute :body, type: :text, translated: true, editor: true
        settings.attribute :columns, type: :integer, default: 6
      end
    end

    Decidim.content_blocks.register(:participatory_process_group_homepage, :calendar) do |content_block|
      content_block.cell = "decidim/alternative_landing/content_blocks/calendar"
      content_block.public_name_key = "decidim.alternative_landing.content_blocks.calendar.name"
    end

    if defined? Decidim::Consultations
      Decidim.content_blocks.register(:participatory_process_group_homepage, :highlighted_consultations) do |content_block|
        content_block.cell = "decidim/alternative_landing/content_blocks/highlighted_consultations"
        content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/highlighted_consultations_settings_form"
        content_block.public_name_key = "decidim.alternative_landing.content_blocks.highlighted_consultations.name"

        content_block.settings do |settings|
          settings.attribute :consultations, type: :array
          settings.attribute :button_text, type: :text, translated: true
          settings.attribute :title, type: :text, translated: true
        end
      end
    end
  end
end
