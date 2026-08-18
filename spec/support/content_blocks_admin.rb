# frozen_string_literal: true

module ContentBlocksAdminHelpers
  # Submits a content block settings form and waits until the browser has
  # actually landed on the landing page layout it redirects to.
  #
  # `click_on` returns as soon as the click has been dispatched, so any `visit`
  # that follows it races with the still in-flight form submission and ends up
  # being overridden by the redirect it answers with.
  def update_content_block(redirect_path)
    click_on "Update"

    expect(page).to have_current_path(redirect_path)
  end
end

RSpec.configure do |config|
  config.include ContentBlocksAdminHelpers, type: :system
end
