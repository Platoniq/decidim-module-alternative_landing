# frozen_string_literal: true

[:homepage, :participatory_process_group_homepage].each do |scope_name|
  Decidim.content_blocks.register(scope_name, :cover_full) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/cover_full"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/cover_full_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.cover_full.name"

    content_block.settings do |settings|
      settings.attribute :title, type: :text, translated: true
      settings.attribute :body, type: :text, translated: true, editor: true
    end

    content_block.images = [{ name: :background_image, uploader: "Decidim::AlternativeLanding::CoverImageUploader" }]
  end

  Decidim.content_blocks.register(scope_name, :cover_half) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/cover_half"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/cover_half_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.cover_half.name"

    content_block.settings do |settings|
      settings.attribute :title, type: :text, translated: true
      settings.attribute :body, type: :text, translated: true, editor: true
      settings.attribute :link_text, type: :text, translated: true
      settings.attribute :link_url, type: :text, translated: true
    end

    content_block.images = [{ name: :background_image, uploader: "Decidim::AlternativeLanding::CoverImageUploader" }]
  end

  Decidim.content_blocks.register(scope_name, :stack_horizontal) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/stack_horizontal"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/stack_horizontal_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.stack_horizontal.name"

    content_block.settings do |settings|
      settings.attribute :title, type: :text, translated: true

      1.upto(3).map do |item_number|
        settings.attribute :"body_#{item_number}", type: :text, translated: true
        settings.attribute :"link_text_#{item_number}", type: :text, translated: true
        settings.attribute :"link_url_#{item_number}", type: :text, translated: true
      end
    end

    content_block.images = 1.upto(3).map { |item_number| { name: :"image_#{item_number}", uploader: "Decidim::AlternativeLanding::ItemImageUploader" } }
  end

  Decidim.content_blocks.register(scope_name, :stack_vertical) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/stack_vertical"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/stack_vertical_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.stack_vertical.name"

    content_block.settings do |settings|
      settings.attribute :title, type: :text, translated: true

      1.upto(3).map do |item_number|
        settings.attribute :"body_#{item_number}", type: :text, translated: true
        settings.attribute :"link_text_#{item_number}", type: :text, translated: true
        settings.attribute :"link_url_#{item_number}", type: :text, translated: true
        settings.attribute :"tag_text_#{item_number}", type: :text, translated: true
        settings.attribute :"tag_url_#{item_number}", type: :text, translated: true
      end
    end

    content_block.images = 1.upto(3).map { |item_number| { name: :"image_#{item_number}", uploader: "Decidim::AlternativeLanding::ItemImageUploader" } }
  end

  Decidim.content_blocks.register(scope_name, :tiles) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/tiles"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/tiles_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.tiles.name"

    content_block.settings do |settings|
      settings.attribute :title, type: :text, translated: true

      1.upto(4).map do |item_number|
        settings.attribute :"title_#{item_number}", type: :text, translated: true
        settings.attribute :"body_#{item_number}", type: :text, translated: true
      end
    end

    content_block.images = 1.upto(4).map { |item_number| { name: :"background_image_#{item_number}", uploader: "Decidim::AlternativeLanding::ItemImageUploader" } }
  end

  Decidim.content_blocks.register(scope_name, :latest_blog_posts) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/latest_blog_posts"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/latest_blog_posts_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.latest_blog_posts.name"

    content_block.settings do |settings|
      settings.attribute :title, type: :text, translated: true
      settings.attribute :link_text, type: :text, translated: true
      settings.attribute :link_url, type: :text, translated: true
      settings.attribute :count, type: :integer, default: 3
      settings.attribute :component_id, type: :integer
    end
  end

  next unless defined? Decidim::Consultations

  Decidim.content_blocks.register(scope_name, :selected_consultations) do |content_block|
    content_block.cell = "decidim/alternative_landing/content_blocks/selected_consultations"
    content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/selected_consultations_settings_form"
    content_block.public_name_key = "decidim.alternative_landing.content_blocks.selected_consultations.name"

    content_block.settings do |settings|
      settings.attribute :consultations, type: :array
      settings.attribute :button_text, type: :text, translated: true
      settings.attribute :title, type: :text, translated: true
    end
  end
end
