# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module DecidimLanding
    # This is the engine that runs on the public interface of decidim_landing.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::DecidimLanding

      initializer "decidim_decidim_landing.assets" do |app|
        app.config.assets.precompile += %w(decidim_decidim_landing_manifest.js decidim_decidim_landing_manifest.css)
      end

      initializer "decidim_decidim_landing.content_blocks" do |app|
        Decidim.content_blocks.register(:homepage, :cover_full) do |content_block|
          content_block.cell = "decidim/content_blocks/cover_full"
          content_block.settings_form_cell = "decidim/content_blocks/cover_full_form"
          content_block.public_name_key = "decidim.content_blocks.cover_full.name"
      
          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true
            settings.attribute :body, type: :text, translated: true, editor: true
          end
  
          content_block.images = [{ name: :background_image, uploader: "Decidim::HomepageImageUploader" }]
          
          content_block.default!
        end
        
        Decidim.content_blocks.register(:homepage, :cover_half) do |content_block|
          content_block.cell = "decidim/content_blocks/cover_half"
          content_block.settings_form_cell = "decidim/content_blocks/cover_half_form"
          content_block.public_name_key = "decidim.content_blocks.cover_half.name"
      
          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true
            settings.attribute :body, type: :text, translated: true, editor: true
            settings.attribute :link_text, type: :text, translated: true
            settings.attribute :link_url, type: :text, translated: true
          end
  
          content_block.images = [{ name: :background_image, uploader: "Decidim::HomepageImageUploader" }]
          
          content_block.default!
        end

        Decidim.content_blocks.register(:homepage, :tiles_4) do |content_block|
          content_block.cell = "decidim/content_blocks/tiles_4"
          content_block.settings_form_cell = "decidim/content_blocks/tiles_4_form"
          content_block.public_name_key = "decidim.content_blocks.tiles_4.name"
      
          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true

            1.upto(4).map do |x|
              settings.attribute :"title_#{x}", type: :text, translated: true
              settings.attribute :"body_#{x}", type: :text, translated: true, editor: true
            end
          end
          
          content_block.images = 1.upto(4).map { |x| { name: :"background_image_#{x}", uploader: "Decidim::HomepageImageUploader" } }
          
          content_block.default!
        end

        Decidim.content_blocks.register(:homepage, :stack_3_horizontal) do |content_block|
          content_block.cell = "decidim/content_blocks/stack_3_horizontal"
          content_block.settings_form_cell = "decidim/content_blocks/stack_3_horizontal_form"
          content_block.public_name_key = "decidim.content_blocks.stack_3_horizontal.name"
      
          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true

            1.upto(3).map do |x|
              settings.attribute :"body_#{x}", type: :text, translated: true, editor: true
            end
          end
          
          content_block.images = 1.upto(3).map { |x| { name: :"image_#{x}", uploader: "Decidim::HomepageImageUploader" } }
          
          content_block.default!
        end

        Decidim.content_blocks.register(:homepage, :stack_3_vertical) do |content_block|
          content_block.cell = "decidim/content_blocks/stack_3_vertical"
          content_block.settings_form_cell = "decidim/content_blocks/stack_3_vertical_form"
          content_block.public_name_key = "decidim.content_blocks.stack_3_vertical.name"
      
          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true

            1.upto(3).map do |x|
              settings.attribute :"body_#{x}", type: :text, translated: true, editor: true
              settings.attribute :"link_text_#{x}", type: :text, translated: true
              settings.attribute :"link_url_#{x}", type: :text, translated: true
              settings.attribute :"tag_text_#{x}", type: :text, translated: true
              settings.attribute :"tag_link_#{x}", type: :text, translated: true
            end
          end
          
          content_block.images = 1.upto(3).map { |x| { name: :"image_#{x}", uploader: "Decidim::HomepageImageUploader" } }
          
          content_block.default!
        end
      end

      def initialize_content_block(scope, name, attributes: [], images: [], default: false)
        Decidim.content_blocks.register(scope, name.to_sym) do |content_block|
          content_block.cell = "decidim/content_blocks/#{name}"
          content_block.settings_form_cell = "decidim/content_blocks/#{name}_form" if attributes.any?
          content_block.public_name_key = "decidim.content_blocks.#{name}.name"
      
          content_block.settings do |settings|
            attributes.each do |name, options|
              settings.attribute name, options
            end
          end

          content_block.images = images.map { |name, uploader| { name: name, uploader: uploader } } if images.any?
          
          content_block.default! if default
        end
      end
    end
  end
end
