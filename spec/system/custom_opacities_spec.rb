# frozen_string_literal: true

require "spec_helper"

describe "Custom opacities", :perform_enqueued do
  let(:organization) { create(:organization, available_locales: [:en]) }

  let(:settings) { {} }
  let!(:cover_full_block) { create(:cover_full_block, organization: organization, settings: settings) }
  let!(:cover_half_block) { create(:cover_half_block, organization: organization, settings: settings) }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  shared_examples_for "default opacities" do
    context "when no custom opacities defined" do
      it "renders default opacities" do
        expect(get_property_value(selector, "--opacity_background_image")).to eq(default_image_background_opacity)
        expect(get_property_value(selector, "--opacity_background_text")).to eq(default_text_background_opacity)
        expect(get_property_value(selector, "--opacity_text")).to eq(default_text_opacity)
        expect(get_property_value(selector, "--opacity_navbar")).to eq(default_navbar_opacity)
      end
    end
  end

  shared_examples_for "custom opacities defined" do
    context "when custom opacities defined" do
      let(:settings) do
        {
          opacity_background_image: 0.33,
          opacity_background_text: 0.44,
          opacity_text: 0.55,
          opacity_navbar: 0.66
        }
      end

      it "renders custom opacities" do
        expect(get_property_value(selector, "--opacity_background_image")).to eq("0.33")
        expect(get_property_value(selector, "--opacity_background_text")).to eq("0.44")
        expect(get_property_value(selector, "--opacity_text")).to eq("0.55")
        expect(get_property_value(selector, "--opacity_navbar")).to eq("0.66")
      end
    end
  end

  describe "cover_full block" do
    let(:selector) { ".cover-full" }
    let(:default_image_background_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_full[:background_image].to_s }
    let(:default_text_background_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_full[:background_text].to_s }
    let(:default_text_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_full[:text].to_s }
    let(:default_navbar_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_full[:navbar].to_s }

    it_behaves_like "default opacities"
    it_behaves_like "custom opacities defined"
  end

  describe "cover_half block" do
    let(:selector) { ".cover-half" }
    let(:default_image_background_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_half[:background_image].to_s }
    let(:default_text_background_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_half[:background_text].to_s }
    let(:default_text_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_half[:text].to_s }
    let(:default_navbar_opacity) { Decidim::AlternativeLanding::DefaultOpacities.cover_full[:navbar].to_s }

    it_behaves_like "default opacities"
    it_behaves_like "custom opacities defined"
  end

  def get_computed_style(selector)
    page.execute_script("return window.getComputedStyle($('#{selector}')[0])").strip
  end

  def get_property_value(selector, variable_name)
    page.execute_script("return window.getComputedStyle($('#{selector}')[0]).getPropertyValue('#{variable_name}')").strip
  end
end
