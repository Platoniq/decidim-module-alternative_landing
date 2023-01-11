# frozen_string_literal: true

namespace :alternative_landing do
  namespace :rename_upcoming_meetings do
    desc "Rename upcoming_meetings from Alternative landing module to alternative_upcoming_meetings"
    task up: :environment do
      # rubocop:disable Rails/SkipsModelValidations
      Decidim::AlternativeLanding::ContentBlock.where(manifest_name: "upcoming_meetings").update_all(manifest_name: "alternative_upcoming_meetings")
      # rubocop:enable Rails/SkipsModelValidations
    end

    desc "Rename alternative_upcoming_meetings from Alternative landing module to upcoming_meetings"
    task down: :environment do
      # rubocop:disable Rails/SkipsModelValidations
      Decidim::AlternativeLanding::ContentBlock.where(manifest_name: "alternative_upcoming_meetings").update_all(manifest_name: "upcoming_meetings")
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
