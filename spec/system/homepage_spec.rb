# frozen_string_literal: true

require "spec_helper"

describe "Visit the home page", type: :system, perform_enqueued: true do
  let(:organization) { create :organization, available_locales: [:en] }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it "renders the home page" do
    expect(page).to have_content("Home")
  end

  context "when there are active alternative landing content blocks" do
    let!(:content_block_1) { create(:cover_full_block, organization: organization) }
    let!(:content_block_2) { create(:cover_half_block, organization: organization) }
    let!(:content_block_3) { create(:stack_horizontal_block, organization: organization) }

    before do
      visit decidim.root_path
    end

    it "renders them" do
      expect(page).to have_selector(".alternative-landing")
      expect(page).to have_selector(".alternative-landing.cover-full")
      expect(page).to have_selector(".alternative-landing.cover-half")
      expect(page).to have_selector(".alternative-landing.stack-horizontal")
    end
  end
end
