# frozen_string_literal: true

require "spec_helper"

describe "Custom colors", type: :system, perform_enqueued: true do
  let(:organization) { create :organization, available_locales: [:en] }

  let(:settings) { {} }
  let!(:cover_full_block) { create(:cover_full_block, organization: organization, settings: settings) }
  let!(:cover_half_block) { create(:cover_half_block, organization: organization, settings: settings) }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  shared_examples_for "custom colors defined" do
    context "when custom colors defined" do
      let(:settings) do
        {
          color_background_image: "#ff0000",
          color_background_text: "#00ff00",
          color_text: "#0000ff",
          color_navbar: "#ffff00"
        }
      end

      it "renders custom colors" do
        expect(get_property_value(selector, "--color_background_image")).to eq("#ff0000")
        expect(get_property_value(selector, "--color_background_text")).to eq("#00ff00")
        expect(get_property_value(selector, "--color_text")).to eq("#0000ff")
        expect(get_property_value(selector, "--color_navbar")).to eq("#ffff00")
      end
    end
  end

  describe "cover_full block" do
    let(:selector) { ".cover-full" }
    let(:default_image_background_color) { Decidim::AlternativeLanding::DefaultColors.cover_full[:background_image] }
    let(:default_text_background_color) { Decidim::AlternativeLanding::DefaultColors.cover_full[:background_text] }
    let(:default_text_color) { Decidim::AlternativeLanding::DefaultColors.cover_full[:text] }
    let(:default_navbar_color) { Decidim::AlternativeLanding::DefaultColors.cover_full[:navbar] }

    it "renders default colors" do
      expect(get_property_value(selector, "--color_background_image")).to eq(get_property_value(selector, "--secondary"))
      expect(get_property_value(selector, "--color_background_text")).to eq(get_property_value(selector, "--secondary"))
      expect(get_property_value(selector, "--color_text")).to eq(default_text_color)
      expect(get_property_value(selector, "--color_navbar")).to eq(default_navbar_color)
    end

    it_behaves_like "custom colors defined"
  end

  describe "cover_half block" do
    let(:selector) { ".cover-half" }
    let(:default_image_background_color) { Decidim::AlternativeLanding::DefaultColors.cover_half[:background_image] }
    let(:default_text_background_color) { Decidim::AlternativeLanding::DefaultColors.cover_half[:background_text] }
    let(:default_text_color) { Decidim::AlternativeLanding::DefaultColors.cover_half[:text] }
    let(:default_navbar_color) { Decidim::AlternativeLanding::DefaultColors.cover_full[:navbar] }

    it "renders default colors" do
      expect(get_property_value(selector, "--color_background_image")).to eq(get_property_value(selector, "--primary"))
      expect(get_property_value(selector, "--color_background_text")).to eq(get_property_value(selector, "--primary"))
      expect(get_property_value(selector, "--color_text")).to eq(default_text_color)
      expect(get_property_value(selector, "--color_navbar")).to eq(default_navbar_color)
    end

    it_behaves_like "custom colors defined"
  end

  def get_computed_style(selector)
    page.execute_script("return window.getComputedStyle($('#{selector}')[0])").strip
  end

  def get_property_value(selector, variable_name)
    page.execute_script("return window.getComputedStyle($('#{selector}')[0]).getPropertyValue('#{variable_name}')").strip
  end
end
