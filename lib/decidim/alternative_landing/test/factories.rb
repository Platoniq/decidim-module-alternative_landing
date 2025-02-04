# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/blogs/test/factories"
require "decidim/meetings/test/factories"

FactoryBot.define do
  factory :alternative_landing_content_block, parent: :content_block do
    scope_name { :homepage }
  end

  factory :cover_full_block, parent: :alternative_landing_content_block do
    manifest_name { :cover_full }
    settings do
      {
        title: generate_localized_title,
        body: Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.paragraph }
      }
    end

    after(:create) do |content_block, _evaluator|
      background_image = Rack::Test::UploadedFile.new(Decidim::Dev.test_file("city.jpeg", "image/jpeg"), "image/jpeg")
      content_block.images_container.background_image = background_image
      content_block.save
    end
  end

  factory :cover_half_block, parent: :alternative_landing_content_block do
    manifest_name { :cover_half }
    settings do
      {
        title: generate_localized_title,
        body: Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.paragraph },
        link_text: Decidim::Faker::Localized.word,
        link_url: Decidim::Faker::Localized.literal("https://decidim.org")
      }
    end

    after(:create) do |content_block, _evaluator|
      background_image = Rack::Test::UploadedFile.new(Decidim::Dev.test_file("city.jpeg", "image/jpeg"), "image/jpeg")
      content_block.images_container.background_image = background_image
      content_block.save
    end
  end

  factory :stack_horizontal_block, parent: :alternative_landing_content_block do
    manifest_name { :stack_horizontal }

    settings do
      item_settings = {}

      1.upto(3).map do |item_number|
        item_settings[:"body_#{item_number}"] = Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.paragraph }
        item_settings[:"link_text_#{item_number}"] = Decidim::Faker::Localized.word
        item_settings[:"link_url_#{item_number}"] = Decidim::Faker::Localized.literal("https://decidim.org")
      end

      item_settings.merge(
        {
          title: generate_localized_title
        }
      )
    end

    after(:create) do |content_block, _evaluator|
      1.upto(3).each do |item_number|
        image = Rack::Test::UploadedFile.new(Decidim::Dev.test_file("city.jpeg", "image/jpeg"), "image/jpeg")
        content_block.images_container.send(:"image_#{item_number}=", image)
      end

      content_block.save!
    end
  end

  factory :stack_vertical_block, parent: :alternative_landing_content_block do
    manifest_name { :stack_vertical }

    settings do
      item_settings = {}

      1.upto(3).map do |item_number|
        item_settings[:"body_#{item_number}"] = Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.paragraph }
        item_settings[:"link_text_#{item_number}"] = Decidim::Faker::Localized.word
        item_settings[:"link_url_#{item_number}"] = Decidim::Faker::Localized.literal("https://decidim.org")
        item_settings[:"tag_text_#{item_number}"] = Decidim::Faker::Localized.word
        item_settings[:"tag_url_#{item_number}"] = Decidim::Faker::Localized.literal("https://decidim.org")
      end

      item_settings.merge(
        {
          title: generate_localized_title
        }
      )
    end

    after(:create) do |content_block, _evaluator|
      1.upto(3).each do |item_number|
        image = Rack::Test::UploadedFile.new(Decidim::Dev.test_file("city.jpeg", "image/jpeg"), "image/jpeg")
        content_block.images_container.send(:"image_#{item_number}=", image)
      end

      content_block.save!
    end
  end

  factory :tiles_block, parent: :alternative_landing_content_block do
    manifest_name { :tiles }

    settings do
      item_settings = {}

      1.upto(4).map do |item_number|
        item_settings[:"title_#{item_number}"] = generate_localized_title
        item_settings[:"body_#{item_number}"] = Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.paragraph }
      end

      item_settings.merge(
        {
          title: generate_localized_title
        }
      )
    end

    after(:create) do |content_block, _evaluator|
      1.upto(4).each do |item_number|
        background_image = Rack::Test::UploadedFile.new(Decidim::Dev.test_file("city.jpeg", "image/jpeg"), "image/jpeg")
        content_block.images_container.send(:"background_image_#{item_number}=", background_image)
      end

      content_block.save!
    end
  end

  factory :latest_blog_posts_block, parent: :alternative_landing_content_block do
    manifest_name { :latest_blog_posts }

    transient do
      component_id { nil }
      count { 3 }
    end

    settings do
      {
        title: generate_localized_title,
        link_text: Decidim::Faker::Localized.word,
        link_url: Decidim::Faker::Localized.literal("https://decidim.org"),
        component_id:,
        count:
      }
    end
  end

  factory :alternative_upcoming_meetings_block, parent: :alternative_landing_content_block do
    manifest_name { :alternative_upcoming_meetings }

    transient do
      component_id { nil }
      count { 3 }
    end

    settings do
      {
        title: generate_localized_title,
        link_text: Decidim::Faker::Localized.word,
        link_url: Decidim::Faker::Localized.literal("https://decidim.org"),
        component_id:,
        count:
      }
    end
  end

  factory :calendar_block, parent: :content_block do
    manifest_name { :calendar }
    scope_name { :participatory_process_group_homepage }
  end

  factory :extra_title_block, parent: :content_block do
    manifest_name { :extra_title }
    scope_name { :participatory_process_group_homepage }
    # rubocop:disable Naming/VariableNumber
    settings do
      {
        link_text_1: Decidim::Faker::Localized.word,
        link_url_1: "https://decidim.org",
        link_icon_name_1: "instagram-line"
      }
    end
    # rubocop:enable Naming/VariableNumber
  end

  factory :extra_information_block, parent: :content_block do
    manifest_name { :extra_information }
    scope_name { :participatory_process_group_homepage }

    settings do
      {
        body: Decidim::Faker::Localized.paragraph
      }
    end
  end
end
