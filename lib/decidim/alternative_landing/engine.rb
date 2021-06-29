# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module AlternativeLanding
    # This is the engine that runs on the public interface of alternative_landing.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::AlternativeLanding

      initializer "decidim_alternative_landing.snippets" do |app|
        app.config.enable_html_header_snippets = true
      end

      initializer "decidim_alternative_landing.assets" do |app|
        app.config.assets.precompile += %w(decidim_alternative_landing_manifest.js decidim_alternative_landing_manifest.css)
      end

      initializer "decidim_alternative_landing.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::AlternativeLanding::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::AlternativeLanding::Engine.root}/app/views")
      end

      initializer "decidim_alternative_landing.content_blocks" do |_app|
        Decidim.content_blocks.register(:homepage, :cover_full) do |content_block|
          content_block.cell = "decidim/alternative_landing/content_blocks/cover_full"
          content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/cover_full_settings_form"
          content_block.public_name_key = "decidim.alternative_landing.content_blocks.cover_full.name"

          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true
            settings.attribute :body, type: :text, translated: true, editor: true
          end

          content_block.images = [{ name: :background_image, uploader: "Decidim::AlternativeLanding::CoverImageUploader" }]
        end

        Decidim.content_blocks.register(:homepage, :cover_half) do |content_block|
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

        Decidim.content_blocks.register(:homepage, :stack_horizontal) do |content_block|
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

        Decidim.content_blocks.register(:homepage, :stack_vertical) do |content_block|
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

        Decidim.content_blocks.register(:homepage, :tiles) do |content_block|
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

        Decidim.content_blocks.register(:homepage, :latest_blog_posts) do |content_block|
          content_block.cell = "decidim/alternative_landing/content_blocks/latest_blog_posts"
          content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/latest_blog_posts_settings_form"
          content_block.public_name_key = "decidim.alternative_landing.content_blocks.latest_blog_posts.name"

          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true
            settings.attribute :link_text, type: :text, translated: true
            settings.attribute :link_url, type: :text, translated: true
            settings.attribute :count, type: :integer, default: 3
            settings.attribute :blog_id, type: :integer
          end
        end

      end

      def initialize_content_block(scope, name, attributes: [], images: [], default: false)
        Decidim.content_blocks.register(scope, name.to_sym) do |content_block|
          content_block.cell = "decidim/alternative_landing/content_blocks/#{name}"
          content_block.settings_form_cell = "decidim/alternative_landing/content_blocks/#{name}_settings_form" if attributes.any?
          content_block.public_name_key = "decidim.content_blocksalternative_landing..#{name}.name"

          content_block.settings do |settings|
            attributes.each do |attribute_name, options|
              settings.attribute attribute_name, options
            end
          end

          content_block.images = images.map { |attribute_name, uploader| { name: attribute_name, uploader: uploader } } if images.any?

          content_block.default! if default
        end
      end
    end
  end
end
